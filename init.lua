_G.log = require("log").new()

local features = {
  "completion",
  "debugging",
  "diagnostic",
  "editor",
  "explorer",
  "formatting",
  "fuzzy",
  "git",
  "lsp",
  "misc",
  "treesitter",
  "ui",
}

require("editor").setup()
require("repl.lua")
require("gui").setup()
require("plugins").setup(features, {
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  change_detection = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
