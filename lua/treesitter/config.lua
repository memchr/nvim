---@type TSConfig
---@diagnostic disable-next-line: missing-fields
local config = {
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
  highlight = {
    enable = true,
    disable = {
      -- NOTE: Dockerfile highlighting is buggy, disabled.
      "dockerfile",
    },
  },
  indent = { enable = true },
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
  -- auto_install = true,
}

local higlight_priorities = {
  go = {
    ["variable.member"] = 200,
    ["string.escape"] = 200,
  },
  printf = {
    character = 1000,
  },
}

return function()
  require("treesitter.highlight").override(higlight_priorities)
  require("treesitter.defer_attach")
  require("nvim-treesitter.configs").setup(config)
end
