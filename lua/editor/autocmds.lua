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
