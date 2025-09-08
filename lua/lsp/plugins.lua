---@module "lazy"
---@type LazySpec[]
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
  },

  -- neovim lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {},
  },
}
