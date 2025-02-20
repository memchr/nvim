return {
  -- TODO: auto pairs
  -- candidates:
  -- mini.pairs + mini.surround from echasnovski/mini.nvim
  -- https://github.com/kylechui/nvim-surround

  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- TODO: text-objects
  -- {
  --   "echasnovski/mini.ai",
  --   event = "VeryLazy",
  --   opts = function()
  --     local ai = require("mini.ai")
  --     return {
  --       n_lines = 500,
  --       custom_textobjects = {
  --         o = ai.gen_spec.treesitter({ -- code block
  --           a = { "@block.outer", "@conditional.outer", "@loop.outer" },
  --           i = { "@block.inner", "@conditional.inner", "@loop.inner" },
  --         }),
  --         f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
  --         c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
  --         t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
  --         d = { "%f[%d]%d+" }, -- digits
  --         e = { -- Word with case
  --           { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
  --           "^().*()$",
  --         },
  --         g = LazyVim.mini.ai_buffer, -- buffer
  --         u = ai.gen_spec.function_call(), -- u for "Usage"
  --         U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     require("mini.ai").setup(opts)
  --     LazyVim.on_load("which-key.nvim", function()
  --       vim.schedule(function()
  --         LazyVim.mini.ai_whichkey(opts)
  --       end)
  --     end)
  --   end,
  -- },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
