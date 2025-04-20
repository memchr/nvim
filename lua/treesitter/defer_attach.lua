local ts = require("nvim-treesitter.configs")
local api = vim.api
local monkey = require("monkey")
local caching = require("nvim-treesitter.caching")
local attached = caching.create_buffer_cache()

-- Attach treesitter modules later in the event loop to avoid UI lookup
monkey.patch(ts, "attach_module", function(attach_sync, mod_name, bufnr, lang)
  if not attached.has(mod_name, bufnr) then
    vim.schedule(function()
      if api.nvim_buf_is_valid(bufnr) then
        attach_sync(mod_name, bufnr, lang)
        attached.set(mod_name, bufnr, true)
      end
    end)
  end
end)

-- Prevents modules being detached without being fully attached first
monkey.patch(ts, "detach_module", function(detach, mod_name, bufnr)
  if attached.has(mod_name, bufnr) then
    -- run after attach
    vim.schedule(function()
      if api.nvim_buf_is_valid(bufnr) then
        detach(mod_name, bufnr)
        attached.remove(mod_name, bufnr)
      end
    end)
  end
end)
