return {
  {
    'David-Kunz/cmp-npm',
    event = 'InsertEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = 'json',
    config = function() require('cmp-npm').setup({}) end,
  },
}
