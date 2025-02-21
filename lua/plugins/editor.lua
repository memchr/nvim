return {
  -- colorise RGB code, etc.
  {
    "catgoose/nvim-colorizer.lua",
    main = "colorizer",
    opts = {
      lazy_load = true,
    },
  },

  -- autopairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
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
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    opts = {},
  },

  -- comments
  {
    "folke/ts-comments.nvim",
    opts = {},
  },

  -- search enhancement
  {
    "folke/flash.nvim",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    enabled = false,
    -- stylua: ignore
    keys = {
      { "<M-f>", mode = { "n" }, function() require("flash").jump() end, desc = "Flash" },
      {"s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      {"r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- global search and replace
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
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
