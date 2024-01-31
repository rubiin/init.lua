local icons = require("utils.icons").ui

return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
          vertical = {
            prompt_position = "top",
          },
        },
        color_devicons = true,
        sorting_strategy = "ascending",
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        prompt_prefix = icons.Telescope, -- or $
        selection_caret = icons.Forward,
        path_display = { "smart" },
        file_ignore_patterns = {
          "%.7z",
          "%.avi",
          "%.JPEG",
          "%.JPG",
          "%.V",
          "%.RAF",
          "%.burp",
          "%.bz2",
          "%.cache",
          "%.class",
          "%.dll",
          "%.docx",
          "%.dylib",
          "%.epub",
          "%.exe",
          "%.flac",
          "%.ico",
          "%.ipynb",
          "%.jar",
          "%.gif",
          "%.bin",
          "%.jpeg",
          "%.jpg",
          "%.lock",
          "%.mkv",
          "%.mov",
          "%.mp3",
          "%.mp4",
          "%.m4a",
          "%.webm",
          "%.otf",
          "%.pdb",
          "%.pdf",
          "%.png",
          "%.rar",
          "%.sqlite3",
          "%.svg",
          "%.swp",
          "%.swf",
          "%.tar",
          "%.tar.gz",
          "%.ttf",
          "%.webp",
          "%.zip",
          ".git/",
          ".gradle/",
          ".idea/",
          ".vale/",
          ".vscode/",
          "__pycache__/*",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "smalljre_*/*",
          "target/",
          "vendor/*",
        },
      },
    },
  },
  -- Telescope related plugins

  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },

  -- TODO: replace this with oil
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    --stylua: ignore
    keys = {
      {
        '<leader>sB',
        "<cmd>Telescope find_files cwd=%:p:h<cr>",
        desc = 'Browse Files (cwd)',
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
    lazy = true,
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      {
        "<leader>cu",
        "<cmd>Telescope undo<cr>",
        desc = "Undo history",
      },
    },
    config = function(_, opts)
      require("telescope").load_extension("undo")
    end,
  },
}
