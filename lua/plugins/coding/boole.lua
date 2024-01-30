return {
  {
    "nat-418/boole.nvim",
    event = "BufReadPost",
    keys = {
      { "<C-a>", "<Cmd>Boole increment<CR>", silent = true },
      { "<C-x>", "<Cmd>Boole decrement<CR>", silent = true },
    },
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        { "production", "development", "stage", "test" },
        { "prod", "dev", "test", "stage" },
        { "start", "end" },
        { "before", "after" },
        { "up", "down" },
        { "plus", "minus" },
        { "smart", "truncate" },
        { "left", "right" },
        { "enable", "disable" },
        { "include", "exclude" },
        { "vim", "nvim" },
        { "BufRead", "BufReadPre", "BufReadPost" }, -- useful for lazyvim configs
        { "BufWrite", "BufWritePre", "BufWritePost" }, -- useful for lazyvim configs
        { "on", "off" },
        { "light", "dark" },
        { "frappe", "latte", "macchiato", "mocha" },
        {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eighth",
          "ninth",
          "tenth",
        },
        {
          "First",
          "Second",
          "Third",
          "Fourth",
          "Fifth",
          "Sixth",
          "Seventh",
          "Eighth",
          "Ninth",
          "Tenth",
        },
        -- js/ts stuff
        { "let", "const" },
        { "public", "private", "protected" },
        { "any", "unknown" },
        { "null", "undefined" },
      },
    },
  },
}
