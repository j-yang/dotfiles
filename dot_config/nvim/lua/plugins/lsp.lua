return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        rust_analyzer = {
          mason = false,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              checkOnSave = true,
              check = { command = "clippy" },
              diagnostics = { enable = true },
              procMacro = { enable = true },
              files = {
                exclude = { ".git", "node_modules", "target" },
                watcher = "client",
              },
            },
          },
        },
      },
    },
  },
}
