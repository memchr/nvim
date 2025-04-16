local M = {}

function M.setup()
  require("editor.autocmds")
  require("editor.options")
  require("editor.keymap")
end

return M
