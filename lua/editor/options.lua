vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- configurations
local g, o, opt = vim.g, vim.o, vim.opt

g.python3_host_prog = "/usr/bin/python3"
-- disable ruby and repl support
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

o.exrc = true

o.number = true
o.numberwidth = 3
o.signcolumn = "yes"
o.guifont = "Cascadia Code:h11"
o.colorcolumn = "80,120" --- width visual marking
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
o.list = true -- show invisible characters

o.ignorecase = true
o.smartcase = true -- don't ignore case with capitals
o.virtualedit = "block"

o.shiftround = true
o.pumblend = 10 -- popup transparency
o.pumheight = 12

o.splitbelow = true
o.splitright = true

o.cursorline = true --- highlight focussed line
o.cursorlineopt = "screenline,number"
o.linebreak = true --- enable line warp

o.completeopt = "menu,menuone,noselect"
-- first <TAB> insert the longest common string, second <TAB> complete the next full match
o.wildmode = "longest:full,full"
