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

  -- icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      stages = "fade",
      top_down = false,
    },
    config = function(_, opts)
      vim.notify = require("notify")
      vim.notify.setup(opts)
    end,
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },

  -- ui components library
  { "MunifTanjim/nui.nvim", lazy = true },

  { "folke/snacks.nvim" },
}
