local M = {}

function M.setup()
  vim.lsp.enable({
    'emmylua_ls',
    'clangd',
    'gopls',
    'rust_analyzer',
    'jsonls',
    'ruff',
    'pyrefly',
    'tombi', -- TOML toolkit
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function (ev)
      -- gqal also format the entire buffer, but unlike lsp.buf.format it moves cursor to the start of file
      vim.keymap.set({ 'n', 'i' }, '<c-s-i>', vim.lsp.buf.format, {
        buf = ev.buf,
        desc = 'format buffer',
      })
    end,
  })
end
return M
