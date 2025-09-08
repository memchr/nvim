---@type vim.lsp.Config
return {
  filetypes = { "haskell", "lhaskell", "cabal" },
  settings = {
    haskell = {
      plugin = {
        semanticTokens = { globalOn = true },
      },
    },
  },
  -- hls can handle single files just fine
  workspace_required = false,
}
