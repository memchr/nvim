local api = vim.api
local au = api.nvim_create_autocmd
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
        local w = api.nvim_get_current_win()
        vim.cmd.wincmd("p")
        api.nvim_win_close(w, true)
        pcall(api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
