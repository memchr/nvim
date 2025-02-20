return {
  -- colorscheme
  {
    "navarasu/onedark.nvim",
    config = function()
      local onedark = require("onedark")
      onedark.setup({
        style = "darker",
      })
      onedark.load()
    end,
  },

  -- tab line
  {
    "akinsho/bufferline.nvim",
    ---@module 'bufferline'
    ---@type bufferline.UserConfig
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neotree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    },
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },

  -- ui components library
  { "MunifTanjim/nui.nvim", lazy = true },

  { "folke/snacks.nvim" },
}
