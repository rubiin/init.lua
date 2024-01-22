return {
  -- which key integration
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      defaults = {
        ['<leader>h'] = { name = '+harpoon' },
        ['<leader>;'] = { name = '+info' },
        ['<leader>T'] = { name = '+terminal' },
        ['<leader>l'] = { name = '+lsp' },
        ['<leader>r'] = { name = '+refactoring' },
      },
    },
  },
}
