return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    opts = {
      servers = require('config.lsp').servers,
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        config.compatibility = require('blink.cmp').get_lsp_capabilities(config.compatibility)
        lspconfig[server].setup(config)
      end
    end
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
