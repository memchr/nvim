local catppuccin = require("catppuccin")
local opts = {
  flavour = "onedark",
  auto_integrations = true,
  styles = {
    -- otherwise modules and namespace uses italics
    miscs = {},
  },
  custom_highlights = function(C)
    local bold = { "bold" }
    return {

      -- Identifers
      Constant = { style = { "bold" } },
      ["@lsp.typemod.const.constant"] = { link = "@constant" },
      --- members
      ["@lsp.typemod.property.classScope"] = { link = "@variable.member" },
      ["@variable.member"] = { fg = C.teal },
      ["@variable.parameter"] = { fg = C.red },

      -- Types
      ["@type.builtin"] = { fg = C.peach },

      -- Functions
      ["@function.builtin"] = { fg = C.sky },

      -- vimdoc
      ["@markup.heading.1.vimdoc"] = { fg = C.blue, style = bold },
      ["@markup.heading.2.vimdoc"] = { fg = C.sapphire, style = bold },
      -- rainbow (bold)
      bold_rainbow1 = { fg = C.red, style = bold },
      bold_rainbow2 = { fg = C.peach, style = bold },
      bold_rainbow3 = { fg = C.yellow, style = bold },
      bold_rainbow4 = { fg = C.green, style = bold },
      bold_rainbow5 = { fg = C.sapphire, style = bold },
      bold_rainbow6 = { fg = C.lavender, style = bold },

      -- markdown
      ["@markup.heading.1.markdown"] = { link = "bold_rainbow1" },
      ["@markup.heading.2.markdown"] = { link = "bold_rainbow2" },
      ["@markup.heading.3.markdown"] = { link = "bold_rainbow3" },
      ["@markup.heading.4.markdown"] = { link = "bold_rainbow4" },
      ["@markup.heading.5.markdown"] = { link = "bold_rainbow5" },
      ["@markup.heading.6.markdown"] = { link = "bold_rainbow6" },

      -- Editor
      Visual = { style = {} },
    }
  end,
  palettes = {
    onedark = {
      rosewater = "#f5e0dc",
      flamingo = "#fccbcb",
      pink = "#fcb8e7",
      mauve = "#c678dd",
      red = "#e06c75",
      maroon = "#f29baa",
      peach = "#d19a66",
      yellow = "#e5c07b",
      green = "#98c379",
      teal = "#96e3cc",
      sky = "#89dceb",
      sapphire = "#74c7ec",
      blue = "#61afef",
      lavender = "#b4befe",

      text = "#abb2bf",
      subtext1 = "#a1a8b5",
      subtext0 = "#8e95a3",
      overlay2 = "#79808e",
      overlay1 = "#656c79",
      overlay0 = "#575d69",

      surface2 = "#535e73",
      surface1 = "#3d475a",
      surface0 = "#2c3340",
      base = "#23272E",
      mantle = "#1a1e24",
      crust = "#1d2026",
    },
    contrast = {
      rosewater = "#efc9c2",
      flamingo = "#ebb2b2",
      pink = "#f2a7de",
      mauve = "#b889f4",
      red = "#ea7183",
      maroon = "#ea838c",
      peach = "#f39967",
      yellow = "#eaca89",
      green = "#96d382",
      teal = "#78cec1",
      sky = "#91d7e3",
      sapphire = "#68bae0",
      blue = "#739df2",
      lavender = "#a0a8f6",
      text = "#b5c1f1",
      subtext1 = "#a6b0d8",
      subtext0 = "#959ec2",
      overlay2 = "#848cad",
      overlay1 = "#717997",
      overlay0 = "#63677f",
      surface2 = "#505469",
      surface1 = "#3e4255",
      surface0 = "#2c2f40",
      base = "#1a1c2a",
      mantle = "#141620",
      crust = "#0e0f16",
    },
  },
}

local function generate_colorscheme(name)
  local path = vim.fs.joinpath(vim.fn.stdpath("config"), "colors", ("catppuccin-%s.vim"):format(name))
  if not vim.uv.fs_stat(path) then
    local f = io.open(path, "w")
    assert(f ~= nil)
    f:write(([[lua require("catppuccin").load "%s"]]):format(name))
    f:close()
  end
end

local function generate_palettes(palettes)
  for name, palette in pairs(palettes) do
    catppuccin.flavours[name] = 42
    package.preload["catppuccin.palettes." .. name] = function()
      return palette
    end
    generate_colorscheme(name)
  end
end

generate_palettes(opts.palettes)
catppuccin.setup(opts)
vim.cmd.colorscheme("catppuccin")
