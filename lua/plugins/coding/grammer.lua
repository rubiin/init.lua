-- check config here: https://writewithharper.com/docs/integrations/neovim

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              userDictPath = "~/.config/cspell.json",
              linters = {
                SentenceCapitalization = false,
                SpellCheck = false
              }
            }
          },
        },
      }
    }
  }
}
