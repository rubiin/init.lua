return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {
      langs = {
        dts = "// %s",
        spec = "# %s",
        gomod = "// %s",
        gowork = "// %s",
        vue = {
          "<!-- %s -->",
          script_element = "// %s",
        },
      },
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "numToStr/Comment.nvim",
    event = { "InsertEnter" },
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = true,
        opts = {
          enable_autocmd = false,
        },
      },
    },
    opts = function(_, opts)
      if not opts then
        opts = {}
      end

      ---Add a space b/w comment and the line
      opts.padding = true
      ---Whether the cursor should stay at its position
      opts.sticky = true

      ---Line which should be ignored while comment/uncomment
      ---Example: Use '^$' to ignore empty lines
      opts.ignore = nil
      opts.toggler = {
        -- line-comment keymap
        line = "gcc",

        --  Make sense to be related to your opleader.block
        block = "gbc",
      }
      -- LHS of operator-pending mapping in NORMAL + VISUAL mode
      opts.opleader = {
        -- line-comment keymap
        line = "gc",
        -- block-comment keymap
        block = "gb",
      }
      -- extra mapping
      -- Includes `gco`, `gcO`, `gcA`
      opts.extra = {
        ---Add comment on the line above
        above = "gcO",
        ---Add comment on the line below
        below = "gco",
        ---Add comment at the end of line
        eol = "gcA",
      }

      -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      opts.mappings = {

        -- operator-pending mapping
        -- Includes:
        --  `gcc`               -> line-comment  the current line
        --  `gcb`               -> block-comment the current line
        --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
        --  `gb[count]{motion}` -> block-comment the region contained in {motion}
        basic = true,

        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      }

      -- to skip backwards compatibility routines and speed up loading
      opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      require("Comment").setup(opts)
    end,
  },
}
