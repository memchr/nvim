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

      -- Variable
      ["@variable.member"] = { fg = C.teal },
      ["@lsp.typemod.property.classScope"] = { link = "@variable.member" },
      ["@variable.parameter"] = { fg = C.red },

      -- Types
      ["@type.builtin"] = { fg = C.peach },
      ["@lsp.type.selfKeyword"] = { fg = C.maroon },

      -- Functions
      ["@function.builtin"] = { fg = C.sapphire },
      ["@lsp.typemod.method.defaultLibrary.rust"] = { link = "@function.builtin" },
      ["@function.macro"] = { fg = C.lavender },

      -- Macro
      ["@keyword.directive.define"] = { link = "keyword" },
      ["@lsp.type.macro.rust"] = { link = "@function.macro" },
      ["@constant.macro"] = { link = "Constant" },
      -- conflicts with constant marco
      ["@lsp.type.macro.c"] = {},

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

      -- vimdoc
      ["@markup.heading.1.vimdoc"] = { link = "bold_rainbow1" },
      ["@markup.heading.2.vimdoc"] = { link = "bold_rainbow2" },
      ["@markup.heading.3.vimdoc"] = { link = "bold_rainbow3" },
      ["@markup.heading.4.vimdoc"] = { link = "bold_rainbow4" },
      ["@markup.heading.5.vimdoc"] = { link = "bold_rainbow5" },
      ["@markup.heading.6.vimdoc"] = { link = "bold_rainbow6" },

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
      maroon = "#f19e97",
      peach = "#d19a66",
      yellow = "#e5c07b",
      green = "#98c379",
      teal = "#a3e5cd",
      sky = "#7ed7d8",
      sapphire = "#56b6c2",
      blue = "#61afef",
      lavender = "#abbaeb",
      text = "#cfd7e8",
      subtext1 = "#b9c4d8",
      subtext0 = "#a4aec3",
      overlay2 = "#919bae",
      overlay1 = "#7d8697",
      overlay0 = "#6a7281",
      surface2 = "#565d6a",
      surface1 = "#434a55",
      surface0 = "#2f343d",
      base = "#23272e",
      mantle = "#1a1e24",
      crust = "#121418",
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
