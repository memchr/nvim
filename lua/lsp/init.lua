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

function M.setup()
  -- update capabilities
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    M.defaults.capabilities = blink.get_lsp_capabilities(M.defaults.capabilities)
  end
  --  auto start lsp when a buffer is opened
  vim.lsp.config("*", M.defaults)
  vim.lsp.enable(M.enabled)
end

return M
