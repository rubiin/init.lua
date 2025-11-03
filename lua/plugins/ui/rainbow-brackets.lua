return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "BufReadPre",
  keys = {
    {
      '<leader>u[',
      function()
        local bufnr = vim.api.nvim_get_current_buf()
        require("rainbow-delimiters").toggle(bufnr)
      end,
      desc = "Toggle Rainbow Brackets",
    },
  },
  init = function()
    ---@type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      blacklist = {
        function(bufnr)
          local is_too_big = require("utils").is_file_big(bufnr)
          if is_too_big then
            return vim.bo.filetype
          end
          return nil
        end,
      },

      strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
      },
      priority = {
        [""] = 110,
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
