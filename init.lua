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
require("lsp").setup()
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

---@type table<number, indent.Opt>
local spaces = { [2] = { size = 2, style = "space" }, [4] = { size = 4, style = "space" } }

require("indent").setup({
  filetype = {
    javascript = spaces[2],
    typescript = spaces[2],
    json = spaces[2],
    jsonc = spaces[2],
    markdown = spaces[2],
    html = spaces[2],
    xml = spaces[2],

    lua = spaces[2],
    nftables = spaces[2],
    python = spaces[4],
    fish = spaces[4],
    c = 4,
    cpp = 4,
    go = 4,
  },
  filename = {
    PKGBUILD = spaces[2],
  },
})
