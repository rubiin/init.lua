return {
  {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = {
      "bash",
      "css",
      "diff",
      "html",
      "javascript",
      "lua",
      "query",
      "regex",
      "toml",
      "vim",
    },
    opts = {
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

-- TODO:  look more on nvim_treesitter_objects
