local M = {}

local map = vim.keymap.set

function M.setup()
  -- clipboard
  map("v", "<c-c>", '"+y')
  map("n", "<c-c>", '"+yy')

  -- LSP
  map('n', '=af', vim.lsp.buf.format, { desc = "Format Document" })
  map("n", "gd", vim.lsp.buf.definition, { desc = 'Goto Definition' })
  map("n", "K", vim.lsp.buf.hover)
end

return M
