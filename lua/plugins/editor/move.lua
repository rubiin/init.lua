return {
  'echasnovski/mini.move', version = '*',
  event = 'BufRead',
  config = function()
  require('mini.move').setup({})
  end
}
