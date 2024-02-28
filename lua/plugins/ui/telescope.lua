local constant = require("utils.constants")
local user_icons = require("custom.icons")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "olimorris/persisted.nvim",
      "rcarriga/nvim-notify",
      "ThePrimeagen/harpoon",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "prochri/telescope-all-recent.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "kkharji/sqlite.lua",
        enabled = not jit.os:find("Windows"),
      },
    },
    lazy = true,
    keys = {
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
        prompt_prefix = user_icons.ui.Telescope, -- or $
        selection_caret = user_icons.ui.SelectionCaret,
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
        telescope.load_extension("ui-select")
        telescope.load_extension("harpoon")
        telescope.load_extension("persisted")

        -- custom telescope extensions
        telescope.load_extension("nerdfont")
        telescope.load_extension("lualine")
      end)
    end,
  },
}
