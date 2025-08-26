local M = {}

M.init_options = {
  config = {
    vetur = {
      completion = {
        autoImport = true,
        tagCasing = "initial",
        useScaffoldSnippets = true,
      },
      useWorkspaceDependencies = true,
      format = {
        scriptInitialIndent = false,
        styleInitialIndent = true,
      },
      validation = {
        script = true,
        style = true,
        template = true,
      },
    },
  },
}

return M
