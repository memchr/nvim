_G.log = require("log").new()

local features = {
  "apperance",
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
require("plugins").setup(features)
require("repl.lua")
require("gui")
