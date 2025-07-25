local M = {}

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
  end
end

return M
