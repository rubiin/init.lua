local icons = require("utils.icons").ui

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true,
        event = "VeryLazy",
      },
      {
        "debugloop/telescope-undo.nvim",
        lazy = true,
        event = "VeryLazy",
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = true,
        event = "VeryLazy",
      },
      "ThePrimeagen/harpoon",
      {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        event = "VeryLazy",
      },
      "rcarriga/nvim-notify",
      {
        "kkharji/sqlite.lua",
        lazy = true,
        event = "VeryLazy",
      },
      {
        "prochri/telescope-all-recent.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {},
      },
    },
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
          "--glob=!node_modules/",
        },
        layout_config = {
          horizontal = { prompt_position = "top", results_width = 0.8 },
          vertical = { mirror = false },
        },
        color_devicons = true,
        sorting_strategy = "ascending",
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        prompt_prefix = icons.Telescope, -- or $
        selection_caret = icons.SelectionCaret,
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
    keys = {
      {
        "<leader>sB",
        "<cmd>Telescope find_files cwd=%:p:h<cr>",
        desc = "Browse Files (cwd)",
      },
      {
        "<leader>cu",
        "<cmd>Telescope undo<cr>",
        desc = "Undo History",
      },
      {
        "<leader>sN",
        function()
          require("telescope").extensions.notify.notify()
        end,
        desc = "Search Notifications",
      },
    },

    config = function(_, opts)
      local lazy_util = require("lazyvim.util")

      local telescope = require("telescope")
      telescope.setup(opts)

      lazy_util.on_load("telescope.nvim", function()
        if lazy_util.has("nvim-notify") then
          require("telescope").load_extension("notify")
        end
        telescope.load_extension("undo")
        telescope.load_extension("file_browser")
        telescope.load_extension("ui-select")
        telescope.load_extension("harpoon")
      end)
    end,
  },
}
