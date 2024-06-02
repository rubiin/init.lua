return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      float = {
        source = true,
      },
      -- if you use native lsp, you can use the following. Otherwise, its pretty much handled by lspsaga
      servers = {
        typos_lsp = {
          settings = {
            diagnosticSeverity = "information",
          },
        },
      },
    },
  },
}
