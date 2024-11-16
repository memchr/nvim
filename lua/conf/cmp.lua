local cmp = require("cmp")
local M = {}

-- doc: https://github.com/hrsh7th/cmp-buffer
-- see doc for optimization
-- according to doc, this source first scan all lines in the newly opened
-- buffer to build an index asynchronously, then keep the index
-- up-to-date by watching reindexing the changed lines synchronously.
local cmp_source_buffer = {
  name = "buffer",
  option = {
    -- don't index buffer larger than 2 megabytes
    get_bufnrs = function()
      local buf = vim.api.nvim_get_current_buf()
      local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
      if byte_size > 2 * 1024 * 1024 then
        return {}
      end
      return { buf }
    end,
  }
}

function M.setup()
  cmp.setup {
    sources = {
      { name = "nvim_lsp" },
      cmp_source_buffer,
      { name = "nvim_lsp_document_symbol" },
      { name = "async_path" }
    },
    -- FIXME: reconfigure this
    preselect = cmp.PreselectMode.Item,
    mapping = cmp.mapping.preset.insert({
      ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
      ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
      -- C-b (back) C-f (forward) for snippet placeholder navigation.
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
          })
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    completion = {
      completeopt = 'menu,menuone,noinsert'
    },

  }
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      cmp_source_buffer,
    }
  })
  -- use cmdline & path source for :
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end

return M
