return {
  'rubiin/fortune.nvim',
  lazy = true,
  event = 'VimEnter',
  config = function()
    require('fortune').setup({
      max_width = 60,
    })
  end,
}
