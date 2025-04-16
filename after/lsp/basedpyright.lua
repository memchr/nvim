---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticSeverityOverrides = {
          reportAny = "information",
          reportImplicitOverride = "none",
          reportMissingParameterType = "none",
          reportUnannotatedClassAttribute = "none",
          reportUnknownArgumentType = "information",
          reportUnknownMemberType = "information",
          reportUnknownParameterType = "none",
          reportUnknownVariableType = "information",
          reportUnusedCallResult = "none",
          reportUnusedVariable = "information",
        },
      },
    },
  },
}
