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

  -- surround actions
  {
    "echasnovski/mini.surround",
    -- stylua: ignore
    keys = {
      { "sa" , desc = "Add Surrounding", mode = { "n", "v" } },
      { "sd" , desc = "Delete Surrounding" },
      { "sf" , desc = "Find Right Surrounding" },
      { "sF" , desc = "Find Left Surrounding" },
      { "sh" , desc = "Highlight Surrounding" },
      { "sr" , desc = "Replace Surrounding" },
      { "sn" , desc = "Update `MiniSurround.config.n_lines`" },
    },
    opts = {},
  },

  -- visual studio like tabout
  { "abecodes/tabout.nvim", opts = {} },

  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble" },
    event = "LazyFile",
    opts = {},
    ---@format disable-next
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    },
  },

  -- TODO: text-objects
}
