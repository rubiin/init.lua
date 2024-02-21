return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "LazyFile",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = function()
      local keys = {
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
      }
      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon").nav.go_to_mark(i)
          end,
          desc = "Go to mark " .. i,
        })
      end
      return keys
    end,
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    },
    config = function(_, options)
      local status_ok, harpoon = pcall(require, "harpoon")
      if not status_ok then
        return
      end

      harpoon.setup(options)
    end,
  },
}

-- TODO: debug this
