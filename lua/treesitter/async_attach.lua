local M = require("nvim-treesitter.configs")
local uv = vim.uv
local caching = require("nvim-treesitter.caching")

local completed_attemps = caching.create_buffer_cache()

local attach_module = M.attach_module
local detach_module = M.detach_module

---@param mod_name string the module name
---@param bufnr integer the buffer
---@param lang string the language of the buffer
function M.attach_module(mod_name, bufnr, lang)
  local handle
  handle = uv.new_async(vim.schedule_wrap(function()
    if handle and not handle:is_closing() then
      attach_module(mod_name, bufnr, lang)
      completed_attemps.set(mod_name, bufnr, true)
      handle:close()
    end
  end))
  assert(handle, "failed to create async handle")
  handle:send()
end

-- Detaches a module to a buffer
---@param mod_name string the module name
---@param bufnr integer the buffer
function M.detach_module(mod_name, bufnr)
  if completed_attemps.has(mod_name, bufnr) then
    detach_module(mod_name, bufnr)
    completed_attemps.remove(mod_name, bufnr)
  end
end
