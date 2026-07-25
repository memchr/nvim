---@diagnostic disable: missing-fields, param-type-mismatch

local M = {}
local H = {}

local accept_index = i -> { cmp -> cmp.accept({ index = i }) }

function H.setup()
  vim.pack.add({ 'gh:saghen/blink.cmp' })
  local cmp = require('blink.cmp')
  cmp.build():pwait()
  cmp.setup({
    -- snippets = { preset = 'mini_snippets' },
    keymap = {
      preset = 'super-tab',
      ['<A-1>'] = accept_index(1),
      ['<A-2>'] = accept_index(2),
      ['<A-3>'] = accept_index(3),
      ['<A-4>'] = accept_index(4),
    },
    appearance = {
      nerd_font_variant = 'normal',
    },
    completion = {
      list = {
        selection = { auto_insert = false },
      },
      menu = {
        max_height = 12,
      },
    },
    sources = {
      providers = {
        lsp = {
          timeout_ms = 100,
        },
        path = {
          ---@type blink.cmp.PathOpts
          opts = {
            show_hidden_files_by_default = true,
            max_entries = 5000,
          },
        },
      },
    },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },
  })
end

function M.setup()
  -- PERF: 6.3ms startup reduction
  vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
    callback = H.setup,
  })
end
return M
