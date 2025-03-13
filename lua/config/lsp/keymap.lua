-- LSP
local map = function(mode, lhs, rhs, opts)
  local o = opts or {}
  o.buffer = true
  vim.keymap.set(mode, lhs, rhs, o)
end
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "K", vim.lsp.buf.hover)
