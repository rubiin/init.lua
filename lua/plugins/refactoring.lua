return {
    -- Refactoring tool
    {
      "ThePrimeagen/refactoring.nvim",
      event = "BufReadPre",
      keys = {
        {
          "<leader>r",
          function()
            require("refactoring").select_refactor()
          end,
          mode = "v",
          noremap = true,
          silent = true,
          expr = false,
        },
      },
      opts = {},
    },
}


