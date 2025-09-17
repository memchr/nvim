--- add plugin runtimes if root_dir is under neovim config or data path
---@param client vim.lsp.Client
local function setup_plugin_runtimes(client)
  if client.root_dir == nil then
    return
  end

  local root_dir = vim.fs.abspath(client.root_dir)
  local in_stdpath = vim
    .iter({
      vim.fn.stdpath("config"),
      vim.fn.stdpath("data"),
    })
    :any(function(stdpath)
      return root_dir:sub(1, #stdpath) == stdpath
    end)

  if not in_stdpath then
    return
  end

  local library = vim.tbl_get(client.settings, "Lua", "workspace", "library") or {}
  client.settings = vim.tbl_deep_extend("force", client.settings, {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = vim.list_extend(
          library,
          vim
            .iter(require("lazy.core.config").spec.plugins)
            :map(function(_, v)
              return vim.fs.joinpath(v.dir, "lua")
            end)
            :totable()
        ),
      },
    },
  })
  client:notify("workspace/didChangeConfiguration", {})
end

---@type vim.lsp.Config
return {
  cmd = { "emmylua_ls", "--editor", "neovim" },

  ---@param client vim.lsp.Client
  on_attach = function(client, bufnr)
    setup_plugin_runtimes(client)

    vim.api.nvim_buf_create_user_command(bufnr, "DumpLuarc", function()
      local settings = vim.deepcopy(vim.tbl_get(client.settings, "Lua") or {})
      settings["$schema"] =
        "https://raw.githubusercontent.com/EmmyLuaLs/emmylua-analyzer-rust/refs/heads/main/crates/emmylua_code_analysis/resources/schema.json"
      local json = vim.json.encode(settings)
      local f, err = io.open(".luarc", "w")
      if f == nil then
        vim.notify(("Failed to dump luarc: %s"):format(err), vim.log.levels.ERROR)
      end
      ---@diagnostic disable: need-check-nil
      f:write(json)
      f:close()
    end, {})
  end,

  settings = {
    -- see: https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md
    Lua = {
      completion = {
        autoRequire = false,
        callSnippet = false,
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
  commands = {},
}
