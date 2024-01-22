-- A list of colorscheme plugin you may want to try. Find what suits you.

return {
  --  add nord
  {
    'gbprod/nord.nvim',
    lazy = true,

  },
  -- add vscode
  {
    'Mofiqul/vscode.nvim',
    lazy = true,
  },
  -- add gruvbox
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
  },

  -- add nightowl
  {
    'oxfist/night-owl.nvim',
    lazy = true,
  },

  -- add material
  {
    'marko-cerovac/material.nvim',
    lazy = true,
  },
  -- add everforest
  {
    'neanias/everforest-nvim',
    lazy = true,
  },
  -- add kanagawa
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
  },

  -- add catppuccin
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = {
      flavour = 'mocha',
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
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = false, custom_bg = 'lualine' },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
