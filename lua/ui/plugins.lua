---@module "lazy"
---@type LazySpec[]
return {
  {
    "navarasu/onedark.nvim",
    config = function()
      local onedark = require("onedark")
      onedark.setup({
        style = "darker",
        colors = {
          comment = "#7f848e",
        },
        highlights = {
          ["@comment"] = { fg = "$comment" },
          ["@lsp.type.comment"] = { fg = "$comment" },
          ["Comment"] = { fg = "$comment" },
        },
      })
      onedark.load()
    end,
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

  -- keymap hints
  {
    "folke/which-key.nvim",
    ---@module 'which-key'
    ---@class wk.Opts
    opts = {
      delay = function(ctx)
        return ctx.plugin and 0 or 600
      end,
    },
  },

  -- ui components library
  { "MunifTanjim/nui.nvim", lazy = true },

  { "folke/snacks.nvim" },
}
