local au = vim.api.nvim_create_autocmd
local function augroup(group)
  return vim.api.nvim_create_augroup(group, { clear = true })
end

au("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

au("FileType", {
  group = augroup("quick_close"),
  pattern = {
    "qf", -- quickfix
    "help",
    "query", -- treesitter query
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

