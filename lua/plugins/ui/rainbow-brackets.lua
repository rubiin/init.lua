return {
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'BufReadPost',
    lazy = true,
    init = function()
      local status_ok, rainbow_delimiters = pcall(require, 'rainbow-delimiters')
      if not status_ok then return end

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
          tsx = 'rainbow-parens',
          javascript = 'rainbow-delimiters-react',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
}
