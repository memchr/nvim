local M = {
  ---@type vim.lsp.Config
  defaults = {},
  enabled = {
    "clangd",
    "basedpyright",
    "ruff",
    "gopls",
    "rust_analyzer",
    "lua_ls",
    "bashls",
    "asm_lsp",
    "taplo",
    "neocmake",
    "jsonls",
    "ts_ls",
    "yamlls",
  },
}
local ok, blink = pcall(require, "blink.cmp")
if ok then
  M.defaults.capabilities = blink.get_lsp_capabilities(M.defaults.capabilities)
end

return M
