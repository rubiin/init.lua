local user_icons = require("rubin.icons")

return {

  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              search_paths = { vim.g.vscode_snippets_path }
            }
          }
        }
      }
    }
  }
}
