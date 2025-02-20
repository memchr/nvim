-- FIXME: move
local Event = require("lazy.core.handler.event")
local lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

Event.mappings.LazyFile = { id = "LazyFile", event = lazy_file_events }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- FIXME: move
local function is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

return {
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     spec = {
  --       { "<BS>", desc = "Decrement Selection", mode = "x" },
  --       { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
  --     },
  --   },
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = {
        enable = true,
        -- NOTE: Dockerfile highlighting is buggy, disabled
        disable = { "dockerfile" },
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        "go",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "grc",
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
      sync_install = false, -- Install parsers asynchronously
      auto_install = true,
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- TODO: configure folding
    end,
  },

  -- TODO: configure
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   event = "VeryLazy",
  --   enabled = true,
  --   config = function()
  --     -- If treesitter is already loaded, we need to run config again for textobjects
  --     if is_loaded("nvim-treesitter") then
  --       local opts = LazyVim.opts("nvim-treesitter")
  --       require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
  --     end
  --
  --     -- When in diff mode, we want to use the default
  --     -- vim text objects c & C instead of the treesitter ones.
  --     local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
  --     local configs = require("nvim-treesitter.configs")
  --     for name, fn in pairs(move) do
  --       if name:find("goto") == 1 then
  --         move[name] = function(q, ...)
  --           if vim.wo.diff then
  --             local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
  --             for key, query in pairs(config or {}) do
  --               if q == query and key:find("[%]%[][cC]") then
  --                 vim.cmd("normal! " .. key)
  --                 return
  --               end
  --             end
  --           end
  --           return fn(q, ...)
  --         end
  --       end
  --     end
  --   end,
  -- },

  -- Automatically add closing tags for HTML and JSX
  -- TODO: configure
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {},
  },
}
