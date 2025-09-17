---@type LazySpec[]
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
  },

  -- neovim lua development
  {
    "folke/lazydev.nvim",
    pin = true,
    ft = "lua",
    cmd = "LazyDev",
    opts = {},
  },
}
