return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "BufReadPre",
  config = function()
    ---@type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
        python = "rainbow-delimiters",
        go = "rainbow-delimiters",
        javascript = "rainbow-delimiters",
        typescript = "rainbow-delimiters",
        tsx = "rainbow-parens",
        jsx = "rainbow-parens",
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }
  end,
}
