local M = {}
local uv = vim.uv
local joinpath = vim.fs.joinpath
local ts = vim.treesitter
local api = vim.api
local config_lua_dir = joinpath(vim.fn.stdpath("config"), "lua")
local specs_csum = joinpath(vim.fn.stdpath("state"), "plugin_specs.csum")
local specs_cache = joinpath(vim.fn.stdpath("cache"), "plugin_specs.luac")

---Extract plugin specs from lua file
---@param file_path string
---@return table
local function extract_specs(file_path)
  -- Read the file content
  local file = io.open(file_path, "r")
  if not file then
    vim.notify("Could not open plugin spec file: " .. file_path)
    return {}
  end
  local source_code = file:read("*a")
  file:close()

  -- Create a buffer and set its content
  local bufnr = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(source_code, "\n"))

  -- Parse and query
  local query = ts.query.parse(
    "lua",
    [[
    (chunk 
      (return_statement 
        (expression_list 
          (table_constructor (field) @spec))))
    ]]
  )
  local parser = ts.get_parser(bufnr, "lua")
  if not parser then
    return {}
  end
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Generate spec strings
  local specs = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == "spec" then
      local start_row, start_col, end_row, end_col = node:range()
      local lines = api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})
      local spec = table.concat(lines, "\n")
      table.insert(specs, spec)
    end
  end
  api.nvim_buf_delete(bufnr, { force = true })
  return specs
end

function M.compile(features)
  local specs = {}
  -- load features
  for _, feature in ipairs(features) do
    local spec_path = joinpath(config_lua_dir, feature, "plugins.lua")
    if uv.fs_stat(spec_path) then
      for _, spec in ipairs(extract_specs(spec_path)) do
        table.insert(specs, spec)
      end
    else
      vim.notify("Feature " .. feature(" does not have plugins"))
    end
  end

  -- create compiler
  local chunk = string.format(
    [[
      return string.dump(function ()
        return {%s}
      end, true)
    ]],
    table.concat(specs, ",\n")
  )
  local compiler = loadstring(chunk)
  if not compiler then
    vim.notify("Specs contain syntax error")
    return
  end

  -- compile and save
  local bytecode_file = assert(io.open(specs_cache, "wb"), "Failed to write bytecode")
  bytecode_file:write(compiler())
  bytecode_file:close()
end

local function need_recompile(features)
  local csum = 0
  for _, feature in ipairs(features) do
    local path = joinpath(config_lua_dir, feature, "plugins.lua")
    local stat = uv.fs_stat(path)
    if stat then
      csum = (csum * 3 + stat.mtime.nsec + stat.ino) % 4294967296
    end
  end

  local csum_file = assert(io.open(specs_csum, "r"), "Failed to read specs checksum")
  local last_csum = tonumber(csum_file:read())
  csum_file:close()

  if last_csum ~= csum then
    csum_file = assert(io.open(specs_csum, "w"), "Failed to update specs checksum")
    csum_file:write(csum)
    csum_file:close()
    return true
  else
    return false
  end
end

function M.spec(features)
  if need_recompile(features) then
    M.compile(features)
  end
  return loadfile(specs_cache)()
end

return M
