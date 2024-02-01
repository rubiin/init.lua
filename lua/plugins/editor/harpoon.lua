return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "LazyFile",
    lazy = true,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    },
    keys = function()
      return {
        {
          "<leader>fm",
          "<cmd>Telescope harpoon marks<cr>",
          desc = "Telescope Harpoon Marks",
        },
        {
          "<leader>hh",
          function()
            require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
          end,
          desc = "Toggle menu",
        },
        {
          "<leader>ha",
          function()
            require("harpoon"):list():append()
          end,
          desc = "Add File",
        },
        {
          "<leader>hc",
          function()
            require("harpoon").mark.clear_all()
          end,
          desc = "Clear All",
        },
        {
          "<leader>hl",
          function()
            require("harpoon").ui.toggle_quick_menu()
          end,
          desc = "Toggle Quick Menu",
        },
        {
          "<leader>hn",
          function()
            require("harpoon").ui.nav_next()
          end,
          desc = "Next File",
        },
        {
          "<leader>hp",
          function()
            require("harpoon").ui.nav_prev()
          end,
          desc = "Previous File",
        },
        {
          "<leader>hp",
          function()
            require("harpoon").mark.rm_file()
          end,
          desc = "Remove File From Harpoon",
        },
        {
          "<leader>h1",
          function()
            require("harpoon").ui.nav_file(1)
          end,
          desc = "Navigate To File 1",
        },
        {
          "<leader>h2",
          function()
            require("harpoon").ui.nav_file(2)
          end,
          desc = "Navigate To File 2",
        },
        {
          "<leader>h3",
          function()
            require("harpoon").ui.nav_file(3)
          end,
          desc = "Navigate To File 3",
        },
        {
          "<leader>h4",
          function()
            require("harpoon").ui.nav_file(4)
          end,
          desc = "Navigate To File 4",
        },
      }
    end,
    config = function(_, options)
      local status_ok, harpoon = pcall(require, "harpoon")
      if not status_ok then
        return
      end

      harpoon.setup(options)
    end,
  },
}
