local M = {}
local lazy = require("config.lazy")
function M.setup()
  require("config.options")
  require("config.keymap").setup()

  lazy.bootstrap()
  lazy.setup()
end

return M
