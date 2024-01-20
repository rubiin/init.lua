return {
  'echasnovski/mini.move', version = '*',
  event = 'VeryLazy',
  lazy = true,
  config = function()
  require('mini.move').setup({})
  end
}
