return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = function()
      local harpoon = require("harpoon")
      local harpoon_mark = harpoon.mark
      local harpoon_ui = harpoon.ui

      return
      {
        {
          "<leader>fm",
          "<cmd>Telescope harpoon marks<cr>",
          desc = "Telescope Harpoon Marks",
        },
        {
          "<leader>hh",
          function()
            harpoon_ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Toggle menu",
        },
        {
          "<leader>ha",
          function()
            harpoon:list():append()
          end,
          desc = "Add File",
        },
        {
          "<leader>hc",
          function()
            harpoon_mark.clear_all()
          end,
          desc = "Clear All",
        },
        {
          "<leader>hl",
          function()
            harpoon_ui.toggle_quick_menu()
          end,
          desc = "Toggle quick menu",
        },
        {
          "<leader>hn",
          function()
            harpoon_ui.nav_next()
          end,
          desc = "Next File",
        },
        {
          "<leader>hp",
          function()
            harpoon_ui.nav_prev()
          end,
          desc = "Previous File",
        },
        {
          "<leader>hp",
          function()
            harpoon_mark.rm_file()
          end,
          desc = "Remove file from harpoon",
        },
        {
          "<leader>h1",
          function()
            harpoon_ui.nav_file(1)
          end,
          desc = "Navigate to file 1",

        },
        {
          "<leader>h2",
          function()
            harpoon_ui.nav_file(2)
          end,
          desc = "Navigate to file 2",

        },
        {
          "<leader>h3",
          function()
            harpoon_ui.nav_file(3)
          end,
          desc = "Navigate to file 3",

        },
        {
          "<leader>h4",
          function()
            harpoon_ui.nav_file(4)
          end,
          desc = "Navigate to file 4",

        }
      }
    end,

    opts = {},
    config = function(_, options)
      local status_ok, harpoon = pcall(require, "harpoon")
      if not status_ok then
        return
      end

      harpoon.setup(options)

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("harpoon")
    end,
  },
  -- which key integration
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>h"] = { name = "+harpoon" },
      },
    },
  },
}
