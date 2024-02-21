return {
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = {
      "bash",
      "css",
      "diff",
      "html",
      "javascript",
      "regex",
      "toml",
      -- these five should always be installed, https://github.com/nvim-treesitter/nvim-treesitter#modules
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
    },
    opts = {
      playground = { enable = true },
      -- Enable Rainbow Parentheses
      rainbow = { enable = true },
      autotag = {
        enable = true,
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
  },
}
