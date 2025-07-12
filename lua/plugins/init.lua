local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local function bootstrap()
  if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

---@param features string[]
---@param config LazyConfig
function M.setup(features, config)
  bootstrap()

  config = config or {}
  config.spec = vim
    .iter(features)
    :map(function(e)
      return { import = e .. ".plugins" }
    end)
    :totable()

  -- User event
  local Event = require("lazy.core.handler.event")
  Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }

  require("lazy").setup(config)
end

return M
