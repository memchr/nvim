require("plugins")

-- configurations
local g, opt = vim.g, vim.opt

g.python3_host_prog = "/usr/bin/python3"
-- disable ruby and repl support
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

--- enable line number and dedicated sign column
opt.number = true
opt.numberwidth = 2
opt.signcolumn = "yes"

--- use termguicolors
--- TODO: disable in VT
opt.termguicolors = true

--- width visual marking
opt.colorcolumn = "80,120"

--- highlight current line
opt.cursorline = true
opt.cursorlineopt = "screenline,number"
--- enable line warp
opt.linebreak = true

-- first <TAB> insert the longest common string, second <TAB> complete the next full match
opt.wildmode = "longest:full,full"
-- TODO: understand timeout

opt.lazyredraw = true

-- TODO: gui
vim.o.guifont = "Cascadia Code:h11"


--------------------
-- Keybinding
--------------------

vim.keymap.set('n', '=af', vim.lsp.buf.format, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', ' a', vim.lsp.buf.code_action)
vim.keymap.set('n', '<F5>', ':w | make!<cr>')
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

vim.keymap.set('v', '<c-c>', '"+y')
vim.keymap.set('n', '<c-c>', '"+yy')

local misc= require("misc")
_G.indent = misc.indent

