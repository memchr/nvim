---@type vim.lsp.Config
return {
  settings = {
    python = {
      -- pyrefly disables diagnostics by default if a config is not found
      pyrefly = {
        displayTypeErrors = "force-on",
      },
    },
  },
}
