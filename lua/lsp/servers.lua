local fs = vim.fs
local uv = vim.uv
---@diagnostic disable: missing-fields
---@type { [string]:lspconfig.Config }
return {
  clangd = {
    cmd = {
      "clangd",
      "--enable-config",
      "--malloc-trim",
      "--header-insertion=never",
      -- INFO: remove after clangd-20
      "--function-arg-placeholders=false",
    },
  },
  basedpyright = {},
  -- jedi_language_server = {},
  ruff = {},
  gopls = {},
  rust_analyzer = {},
  lua_ls = {},
  bashls = {},
  asm_lsp = {},
  -- sqls = {
  --   root_dir = util.root_pattern("sqls.yml"),
  --   on_new_config = function(config, root_dir)
  --     local config_file = fs.joinpath(root_dir, "sqls.yml")
  --     if uv.fs_stat(config_file) then
  --       config.cmd = { "sqls", "--config", config_file }
  --     end
  --   end,
  -- },
  taplo = {},
  neocmake = {},
  jsonls = {},
  ts_ls = {},
  yamlls = {},
  -- denols = {
  --   single_file_support = true,
  -- },
}
