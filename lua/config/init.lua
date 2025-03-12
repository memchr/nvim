local M = {}
function M.setup()
  require("config.options")
  require("config.keymap").setup()
  require("config.plugins").setup()
end

return M
