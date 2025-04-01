local M = {}
function M.setup()
  require("editor.options")
  require("editor.keymap").setup()
end

return M
