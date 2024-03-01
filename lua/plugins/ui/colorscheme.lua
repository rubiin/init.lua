local lazy_util = require("lazyvim.util")

-- these are neovim built-in colorscheme
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
}
local get_colorsheme = function()
  local target = vim.fn.getcompletion

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.getcompletion = function()
    return vim.tbl_filter(function(color)
      return not vim.tbl_contains(builtins, color)
      ---@diagnostic disable-next-line: param-type-mismatch
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
        barbecue = {
          dim_dirname = true, -- directory name is dimmed by default
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        cmp = true,
        dashboard = true,
        dropbar = {
          enabled = true,
          color_mode = true, -- enable color for kind's texts, not just kind's icons
        },
        gitsigns = true,
        headlines = true,
        illuminate = true,
        leap = true,
        lsp_trouble = true,
        lsp_saga = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = true,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        rainbow_delimiters = true,
        which_key = true,
      },
    },
  },
}
