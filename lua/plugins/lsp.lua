return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    config = function()
      local lspconfig = require("lspconfig")
      local lsp = require("config.lsp")
      for server, config in pairs(lsp.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        config.settings = lsp.settings
        lspconfig[server].setup(config)
      end
    end,
  },

  -- neovim lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
