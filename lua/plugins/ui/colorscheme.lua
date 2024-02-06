local lazy_util = require("lazyvim.util")

local builtins = {
  "zellner",
  "torte",
  "slate",
  "shine",
  "ron",
  "quiet",
  "peachpuff",
  "pablo",
  "murphy",
  "lunaperche",
  "koehler",
  "industry",
  "evening",
  "elflord",
  "desert",
  "delek",
  "default",
  "darkblue",
  "blue",
  "morning",
  "retrobox",
  "sorbet",
  "zaibatsu",
  "wildcharm",
  "vim",
  "habamax",
  "tokyonight",
}

local get_colorsheme = function()
  local target = vim.fn.getcompletion

  vim.fn.getcompletion = function()
    return vim.tbl_filter(function(color)
      return not vim.tbl_contains(builtins, color)
    end, target("", "color"))
  end

  lazy_util.telescope("colorscheme", { enable_preview = true })()
  vim.fn.getcompletion = target
end
-- A list of colorscheme plugin you may want to try. Find what suits you.
return {
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
  },
  --  add nord
  {
    "gbprod/nord.nvim",
    lazy = true,
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
  },
  -- one dark theme
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
  },

  -- add vscode
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
  },

  -- add material
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
  },
  -- add everforest
  {
    "neanias/everforest-nvim",
    lazy = true,
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
  },

  -- add kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
  },

  -- add catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = false, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        noices = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        rainbow_delimiters = true,
        which_key = true,
      },
    },
  },
}
