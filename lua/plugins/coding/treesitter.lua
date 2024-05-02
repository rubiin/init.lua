return {
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      opts.playground = { enable = true }
      opts.autotag = {
        enable = true,
      }
      opts.highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
      }
      opts.autopairs = {
        enable = true,
      }
      opts.textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      }

      opts.indent = { enable = true, disable = { "python", "css" } }

      opts.context_commentstring = {
        enable = true,
        enable_autocmd = false,
      }

      -- auto tag
      opts.autotag = {
        enable = true,
      }
    end,
  },
}
