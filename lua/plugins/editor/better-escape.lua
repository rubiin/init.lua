return {
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    lazy = true,
    config = function()
      require('better_escape').setup({})
    end
  },
}
