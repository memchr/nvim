return {
  Lua = {
    workspace = {
      checkThirdParty = false,
    },
    codeLens = {
      enable = true,
    },
    completion = {
      callSnippet = "Disable",
    },
    doc = {
      privateName = { "^_" },
    },
    hint = {
      enable = true,
      setType = false,
      paramType = true,
      paramName = "Disable",
      semicolon = "Disable",
      arrayIndex = "Disable",
    },
    runtime = {
      version = "LuaJIT",
    },
  },
  gopls = {
    semanticTokens = true,
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
  },
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
        reportUnusedCallResult = "information",
        reportUnusedVariable = "information",
      },
    },
  },
  evenBetterToml = {
    formatter = {
      arrayAutoCollapse = false,
      arrayAutoExpand = false,
    },
  },
}
