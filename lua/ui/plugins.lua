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
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    commit = "30fa4d122d9b22ad8b2e0ab1b533c8c26c4dde86",
    ---@type CatppuccinOptions
    ---@diagnostic disable-next-line
    config = function(self)
      require("ui.catppuccin")
      vim.cmd.colorscheme("catppuccin")

      vim.api.nvim_create_user_command("ReloadTheme", function()
        -- reload palettes
        package.loaded["ui.catppuccin"] = nil
        require("ui.catppuccin")
        -- remove palette cache
        for name, _ in pairs(package.loaded) do
          if name:match("^catppuccin.") then
            package.loaded[name] = nil
          end
        end
        -- reload theme
        vim.cmd.colorscheme("catppuccin")
      end, {})
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
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        -- set to a lower rate to filter out short-lved tasks
        -- unit: Hz
        poll_rate = 10,
        lsp = {
          -- small ringbuf size leads to completion message being dropped
          -- Workaround for https://github.com/j-hui/fidget.nvim/issues/167
          progress_ringbuf_size = 1024,
        },
        ignore_done_already = true,
        -- issue https://github.com/j-hui/fidget.nvim/issues/171
        ignore_empty_message = true,
        display = {},
      },
      notification = {
        override_vim_notify = true,
        window = {
          max_width = 80,
          winblend = 0,
        },
      },
    }, -- end of config
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
