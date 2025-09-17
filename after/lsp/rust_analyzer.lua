local settings = {
  -- When enabled, loads all workspace data before it's actually requests
  -- reduce latency on first use of a symbol, but negatively affects startup time and increase initial memory usage
  cachePriming = {
    enable = true,
  },
  -- lspMux = {
  --   version = "1",
  --   method = "connect",
  --   server = "rust-analyzer",
  -- },
}
---@type vim.lsp.Config
return {
  -- cmd = vim.lsp.rpc.connect("/run/user/1000/ra.sock"),
  settings = {
    ["rust-analyzer"] = settings,
  },
}
