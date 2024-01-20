return {
  {
    'David-Kunz/cmp-npm',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = 'json',
    config = function()
    require('cmp-npm').setup({})
    end,
  },
}
