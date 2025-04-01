---@type LazySpec[]
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    config = require("lsp").config,
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
