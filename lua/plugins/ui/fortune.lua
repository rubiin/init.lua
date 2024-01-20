return {
  'rubiin/fortune.nvim',
  config = function()
    require('fortune').setup({
      max_width = 60,
    })
  end,
  event = 'BufRead',
}
