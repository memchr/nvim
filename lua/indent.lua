---@class indent.Opt
---@field size number
---@field style "space"|"tab"

---@class indent.SetupOpt
---@field filetype table<string,indent.Opt|number>
---@field filename table<string,indent.Opt|number>?

local M = {}

---@param bufnr integer
---@param opt indent.Opt | number
local function indent(bufnr, opt)
  local bo = vim.bo
  local indent_size
  local expandtab = false

  if type(opt) == "number" then
    indent_size = opt
  elseif type(opt) == "table" then
    indent_size = opt.size
    expandtab = opt.style == "space"
  else
    error("Unrecognised indent option")
  end

  bo[bufnr].expandtab = expandtab
  if indent_size ~= nil then
    bo[bufnr].tabstop = indent_size
    bo[bufnr].shiftwidth = indent_size
    bo[bufnr].softtabstop = -1
  end
end

--- Set the default indentation style. The .editorconfig file takes precedence.
---@param opt indent.SetupOpt
function M.setup(opt)
  local group = vim.api.nvim_create_augroup("user.indent", { clear = true })
  -- By filetype
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = vim.tbl_keys(opt.filetype),
    callback = function(ev)
      indent(ev.buf, opt.filetype[ev.match])
    end,
  })

  -- By filename
  if opt.filename ~= nil then
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufFilePost" }, {
      group = group,
      pattern = vim.tbl_keys(opt.filename),
      callback = function(ev)
        local editorconfig = vim.b[ev.buf].editorconfig
        if editorconfig == nil or next(editorconfig) == nil then
          indent(ev.buf, opt.filename[ev.file])
        end
      end,
    })
  end
end
return M
