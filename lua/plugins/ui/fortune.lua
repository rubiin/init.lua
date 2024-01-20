return {
  'rubiin/fortune.nvim',
  lazy = true,
  config = function()
    require('fortune').setup({
      max_width = 60,
    })
  end,
  event = 'BufRead',
}
