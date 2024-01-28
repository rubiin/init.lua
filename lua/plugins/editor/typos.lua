-- TODO: remove unwanted codespell, misspell, proselint, write-good

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {
          settings = {
            diagnosticSeverity = "Warning",
          },
        },
      },
    },
  },
}
