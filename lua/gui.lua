local M = {}

-- terminal colour
local function set_termcolor()
  local g = vim.g
  -- Normal/regular colors (color palette 0-7)
  g.terminal_color_0 = "#353b45"
  g.terminal_color_1 = "#e06c75"
  g.terminal_color_2 = "#98c379"
  g.terminal_color_3 = "#e5c07b"
  g.terminal_color_4 = "#61afef"
  g.terminal_color_5 = "#c678dd"
  g.terminal_color_6 = "#61b6c2"
  g.terminal_color_7 = "#c7d0e0"

  -- Bright colors (color palette 8-15)
  g.terminal_color_8 = "#565c64"
  g.terminal_color_9 = "#ff6370"
  g.terminal_color_10 = "#c2f99a"
  g.terminal_color_11 = "#ffc556"
  g.terminal_color_12 = "#49adff"
  g.terminal_color_13 = "#e077ff"
  g.terminal_color_14 = "#66eeff"
  g.terminal_color_15 = "#ffffff"
end

function M.setup()
  if vim.g.neovide then
    vim.keymap.set(
      { "n", "v" },
      "<C-=>",
      ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
      { silent = true }
    )
    vim.keymap.set(
      { "n", "v" },
      "<C-->",
      ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
      { silent = true }
    )
    vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
    set_termcolor()
  end
end

return M
