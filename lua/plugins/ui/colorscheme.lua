local util = require("utils")

-- these are neovim built-in colorscheme
local builtins = {}

for name, _ in vim.fs.dir("$VIMRUNTIME/colors/") do
  if name:match("*.txt") then
    break
  else
    name = name:match("(.*).lua$") or name:match("(.*).vim$")
    table.insert(builtins, name)
  end
end

local get_colorsheme = function()
  local target = vim.fn.getcompletion

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.getcompletion = function()
    return vim.tbl_filter(function(color)
      return not vim.tbl_contains(builtins, color)
      ---@diagnostic disable-next-line: param-type-mismatch
    end, target("", "color"))
  end

  LazyVim.pick("colorscheme", { enable_preview = true })()
  vim.fn.getcompletion = target
end

-- A list of colorscheme plugin you may want to try. Find what suits you.
return {
  -- add onedarkpro
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
  -- add catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    keys = {
      { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
    },
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
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
