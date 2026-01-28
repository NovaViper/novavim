return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- Ruff is handling this
      analysis = {
        autoImportCompletions = true, -- Perform suggestions for auto-import completions
        autoSearchPaths = true, -- Add common search paths automatically
        diagnosticMode = "workspace", -- Scan all files in the workspace
        typeCheckingMode = "basic", -- Literally way too much going on here, man
        useLibraryCodeForTypes = true, -- Show type information
      },
    },
  },
}
