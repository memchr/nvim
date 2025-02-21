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

  -- Move Lines
  map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
  map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
  map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
  map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
  map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
  map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
  map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
  map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
  map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
  map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
  map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

  -- Add undo break-points
  map("i", ",", ",<c-g>u")
  map("i", ".", ".<c-g>u")
  map("i", ";", ";<c-g>u")

  -- save file
  map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

  -- return to visual mode with same previous selection area after indenting
  map("v", "<", "<gv")
  map("v", ">", ">gv")

  -- clipboard
  map("v", "<c-c>", '"+y')
  map("n", "<c-c>", '"+yy')

  -- LSP
  map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
  map("n", "K", vim.lsp.buf.hover)
end

return M
