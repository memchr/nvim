local M = {
  servers = require("lsp.servers"),
  settings = require("lsp.settings"),
}
function M.config()
  local lspconfig = require("lspconfig")
  for server, config in pairs(M.servers) do
    config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
    config.settings = M.settings
    lspconfig[server].setup(config)
  end
end
return M
