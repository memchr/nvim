local fs = vim.fs
local uv = vim.uv
local util = require("lspconfig.util")
---@diagnostic disable: missing-fields
---@type { [string]:lspconfig.Config }
return {
  clangd = {
    cmd = {
      "clangd",
      "--enable-config",
      "--malloc-trim",
      -- INFO: remove after clangd-20
      "--function-arg-placeholders=false",
    },
  },
  basedpyright = {},
  ruff = {},
  gopls = {},
  rust_analyzer = {},
  lua_ls = {},
  bashls = {},
  asm_lsp = {},
  sqls = {
    root_dir = util.root_pattern("sqls.yml"),
    on_new_config = function(config, root_dir)
      local config_file = fs.joinpath(root_dir, "sqls.yml")
      if uv.fs_stat(config_file) then
        config.cmd = { "sqls", "--config", config_file }
      end
    end,
  },
  taplo = {},
  neocmake = {},
  jsonls = {},
}
