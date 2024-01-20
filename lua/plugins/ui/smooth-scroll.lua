return {
  'karb94/neoscroll.nvim',
  event = 'BufRead',
  lazy = true,
  config = function() require('neoscroll').setup({}) end,
}
