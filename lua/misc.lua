
local M = {}
local opt = vim.opt

--- Set indentation
---
---@param tab_size number Number of spaces that a <Tab> in the file counts for
---@param expandtab? boolean If true, insert spaces
---@param soft? boolean If true, change `softtabstop` insteaed of `tabstop`
function M.indent(tab_size, expandtab, soft)
  ---@diagnostic disable: assign-type-mismatch
  vim.validate({
    tab_size = { tab_size, "n" },
    expandtab = { expandtab, "b", true },
    soft = { soft, "b", true },
  })
  opt.expandtab = expandtab
  if soft then
    opt.softtabstop = tab_size
  else
    opt.tabstop = tab_size
  end
  opt.shiftwidth = tab_size
end

return M

