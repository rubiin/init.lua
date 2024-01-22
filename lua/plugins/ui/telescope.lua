return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    opts = {
      defaults = {
        file_ignore_patterns = {
          file_ignore_patterns = {
            '%.7z',
            '%.avi',
            '%.JPEG',
            '%.JPG',
            '%.V',
            '%.RAF',
            '%.burp',
            '%.bz2',
            '%.cache',
            '%.class',
            '%.dll',
            '%.docx',
            '%.dylib',
            '%.epub',
            '%.exe',
            '%.flac',
            '%.ico',
            '%.ipynb',
            '%.jar',
            '%.jpeg',
            '%.jpg',
            '%.lock',
            '%.mkv',
            '%.mov',
            '%.mp4',
            '%.webm',
            '%.otf',
            '%.pdb',
            '%.pdf',
            '%.png',
            '%.rar',
            '%.sqlite3',
            '%.svg',
            '%.tar',
            '%.tar.gz',
            '%.ttf',
            '%.webp',
            '%.zip',
            '.git/',
            '.gradle/',
            '.idea/',
            '.vale/',
            '.vscode/',
            '__pycache__/*',
            'build/',
            'env/',
            'gradle/',
            'node_modules/',
            'smalljre_*/*',
            'target/',
            'vendor/*',
          },
        },
      },
    },
  },
  -- Telescope related plugins
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
    config = function() require('telescope').load_extension('fzf') end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    lazy = true,
    --stylua: ignore
    keys = {
      {
        '<leader>sB',
        ':Telescope file_browser path=%:p:h=%:p:h<cr>',
        desc = 'Browse Files',
      },
    },
    config = function() require('telescope').load_extension('file_browser') end,
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function() require('telescope').load_extension('ui-select') end,
  },

  {
    'debugloop/telescope-undo.nvim',
    lazy = true,
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    keys = {
      {
        '<leader>cu',
        '<cmd>Telescope undo<cr>',
        desc = 'Undo history',
      },
    },
    config = function(_, opts) require('telescope').load_extension('undo') end,
  },
}
