--- experimental lua module loader with bytecode caching
vim.loader.enable()
vim.g.mapleader = ' ' -- Use <Space> as leader key

require('user.profile').setup()
require('user.debug').setup()

vim.pack.add({
  'gh:folke/snacks.nvim',
  'gh:neovim/nvim-lspconfig',
  'gh:saghen/blink.lib',
  'gh:nvim-mini/mini.nvim',
  'gh:saghen/blink.pairs',
  'gh:rafamadriz/friendly-snippets',
})

require('mini.icons').setup()
require('user.completion').setup()
require('user.lsp').setup()

function vim.pack.cleanup()
  vim.pack.del(
    vim.iter(vim.pack.get())
      :filter(x -> !x.active)
      :map(x -> x.spec.name)
      :totable()
  )
end

local o = vim.o

-- basic
o.exrc = true -- Enable initialization commands

-- Appearance
o.breakindent = true -- Indent wrapped lines to match line start

o.cursorline = true  -- Highlight current line
o.linebreak  = true  -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.number     = true  -- Show line numbers
o.signcolumn = 'yes' -- Always show sign column (otherwise it will shift text)
o.splitbelow = true  -- Horizontal splits will be below
o.splitright = true  -- Vertical splits will be to the right

o.completeopt = 'longest,menuone,noselect,popup'

vim.cmd [[filetype plugin indent on]]

-- pairs
local pairs = require('blink.pairs')
pairs.build():pwait()
pairs.setup({})

-- jump
local keymap = require('mini.keymap')
keymap.map_multistep('i', '<C-l>', { 'jump_after_tsnode', 'jump_after_close' })
keymap.map_multistep('i', '<C-h>', { 'jump_before_tsnode', 'jump_before_open' })

require('mini.files').setup()
require('mini.notify').setup({
  window = {
    config = function ()
      local row = o.lines - o.cmdheight - (o.laststatus >= 2 and 1 or 0)
      return { border = 'solid', anchor = 'SE', row = row }
    end,
  },
})
vim.diagnostic.config({
  float = {
    source = true,
  },
})
vim.keymap.set({ 'n' }, '\\', || -> require('mini.files').open())
