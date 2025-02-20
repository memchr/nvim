return {
  -- colorise RGB code, etc.
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    main = "colorizer",
    opts = {
      lazy_load = true,
    },
  },

  -- autopairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
    },
  },

  -- visual studio like tabout
  { "abecodes/tabout.nvim", opts = {}, },

  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
  },

  -- TODO: text-objects

}
