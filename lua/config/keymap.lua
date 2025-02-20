local M = {}

local map = vim.keymap.set

function M.setup()
  -- Move to window using the <ctrl> hjkl keys
  map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

  -- Resize window using <ctrl> arrow keys
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

  -- clipboard
  map("v", "<c-c>", '"+y')
  map("n", "<c-c>", '"+yy')

  -- LSP
  map('n', '=af', vim.lsp.buf.format, { desc = "Format Document" })
  map("n", "gd", vim.lsp.buf.definition, { desc = 'Goto Definition' })
  map("n", "K", vim.lsp.buf.hover)
end

return M
