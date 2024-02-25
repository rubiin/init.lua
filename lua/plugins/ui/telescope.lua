local user_icons = require("custom.icons").ui
local constant = require("utils.constants")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "olimorris/persisted.nvim",
      "rcarriga/nvim-notify",
      {
        "ThePrimeagen/harpoon",
        lazy = true,
        event = "VeryLazy",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
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
      {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        event = "VeryLazy",
      },
      {
        "kkharji/sqlite.lua",
        lazy = true,
        enabled = not jit.os:find("Windows"),
        event = "VeryLazy",
      },
      {
        "prochri/telescope-all-recent.nvim",
        lazy = true,
        event = "VeryLazy",
      },
    },
    lazy = true,
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
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        prompt_prefix = user_icons.Telescope, -- or $
        selection_caret = user_icons.SelectionCaret,
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
        telescope.load_extension("persisted")
      end)
    end,
  },
}
