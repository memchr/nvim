---@type LazySpec[]
return {
  { "nfnty/vim-nftables" },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup()
    end,
  },
}
