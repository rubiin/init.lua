return {
  --{ "nathom/filetype.nvim" },
  { "dstein64/vim-startuptime" },
  -- vim tmux
  {
    "christoomey/vim-tmux-navigator",

    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  --   {
  --     'hiphish/rainbow-delimiters.nvim',
  --     dependencies = "nvim-treesitter/nvim-treesitter",
  --     event = "VeryLazy",
  --     config = function()
  --         local rainbow = require 'rainbow-delimiters'

  --         vim.g.rainbow_delimiters = {
  --             -- Each language is based on a treesitter language name.

  --             -- Defines the highlighting strategy.
  --             strategy = {
  --                 --[[
  --                 'global' - Highlight all delimiters, updates with document
  --                            changes.
  --                 'local'  - Highlight only the subtree that contains the cursor,
  --                            updates when the cursor moves.
  --                 --]]
  --                 -- Default Strategy
  --                 [''] = rainbow.strategy['global'],
  --                 html = rainbow.strategy['local'],
  --                 latex = function()
  --                     -- Disabled for very large files,
  --                     if vim.fn.line('$') > 10000 then
  --                         return nil
  --                         -- global strategy for large files,
  --                     elseif vim.fn.line('$') > 1000 then
  --                         return rainbow.strategy['global']
  --                     end
  --                     -- local strategy otherwise
  --                     return rainbow.strategy['local']
  --                 end
  --             },

  --             -- Defines what to match
  --             query = {
  --                 -- Default Query - Reasonable set of parenthesis and similar
  --                 -- delimiters in most languages
  --                 [''] = 'rainbow-delimiters',
  --                 -- Matches `\begin` and `\end` instructions
  --                 latex = 'rainbow-blocks',
  --                 -- Matches keywords like `function` and `end` as well as
  --                 -- parenthesis
  --                 lua = 'rainbow-blocks',
  --                 -- Includes React support
  --                 javascript = 'rainbow-delimiters-react',
  --                 --[[
  --                 -- Only parenthesis without React tags
  --                 javascript = 'rainbow-parens',
  --                 -- Only typescript highlighting without React tags
  --                 tsx = 'rainbow-parens',
  --                 --]]
  --                 -- Matches keywords like `begin` and `end` as well as
  --                 -- parenthesis
  --                 verilog = 'rainbow-blocks',
  --             },
  --             highlight = {
  --                 'RainbowDelimiterRed',
  --                 'RainbowDelimiterYellow',
  --                 'RainbowDelimiterBlue',
  --                 'RainbowDelimiterOrange',
  --                 'RainbowDelimiterGreen',
  --                 'RainbowDelimiterViolet',
  --                 'RainbowDelimiterCyan',
  --             },
  --             --[[
  --             blacklist = {
  --                 'c',
  --                 'cpp',
  --             },
  --             whitelist = {
  --                 'python',
  --                 'javascript',
  --             },
  --             log = {
  --                 file = '~/.local/state/lvim/rainbow-delimiters.log',
  --                 level = vim.log.levels.DEBUG,
  --             },
  --             --]]
  --         }
  --     end
  -- }
  -- waka time
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  -- ufo code folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      -- Use treesitter as a main provider
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(virtual_text, left_number, end_line_number, width, truncate)
        local new_virtual_text = {}
        local suffix = (" 󰁂 %d "):format(end_line_number - left_number)
        local suffix_width = vim.fn.strdisplaywidth(suffix)
        local target_width = width - suffix_width
        local current_width = 0
        for _, chunk in ipairs(virtual_text) do
          local chunk_text = chunk[1]
          local chunk_width = vim.fn.strdisplaywidth(chunk_text)
          if target_width > current_width + chunk_width then
            table.insert(new_virtual_text, chunk)
          else
            chunk_text = truncate(chunk_text, target_width - current_width)
            local hl_group = chunk[2]
            table.insert(new_virtual_text, { chunk_text, hl_group })
            chunk_width = vim.fn.strdisplaywidth(chunk_text)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if current_width + chunk_width < target_width then
              suffix = suffix .. (" "):rep(target_width - current_width - chunk_width)
            end
            break
          end
          current_width = current_width + chunk_width
        end
        table.insert(new_virtual_text, { suffix, "MoreMsg" })
        return new_virtual_text
      end,
    },

    --stylua: ignore

    keys = {
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Except Kinds", },
      { "zR", function() require("ufo").openAllFolds() end,         desc = "Open All Folds", },
      { "zM", function() require("ufo").closeAllFolds() end,        desc = "Close All Folds", },
      { "zm", function() require("ufo").closeFoldsWith() end,       desc = "Close Folds With", },
      {
        "zp",
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek Fold",
      },
    },
  },

  -- zen mode for distraction free editing
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        alacritty = { enabled = false, font = "+2" },
      },
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 0.85,    -- width will be 85% of the editor width
      },
    },
    config = true,

    --stylua: ignore
    keys = {
      { "<leader>zz", function() require("zen-mode").openAllFolds() end, desc = "Zen mode", },
    },
  },
  {
    "echasnovski/mini.misc",
    config = true,

    --stylua: ignore
    keys = {
      { "<leader>uz", function() require("mini.misc").zoom() end, desc = "Toggle Zoom" },
    },
  },

  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
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

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm({ select = true })
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- Telescope related plugins
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",

    --stylua: ignore
    keys = {
      {
        "<leader>sB",
        ":Telescope file_browser path=%:p:h=%:p:h<cr>",
        desc = "Browse Files",
      },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>su",
        "<cmd>Telescope undo<cr>",
        desc = "Undo history",
      },
    },
    opts = {},
    config = function(_, opts)
      require("telescope").load_extension("undo")
    end,
  },
}
