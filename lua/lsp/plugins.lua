---@type LazySpec[]
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    config = function()
      local lsp = require("lsp")

      vim.lsp.config("*", lsp.defaults)
      vim.lsp.enable(lsp.enabled)
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
