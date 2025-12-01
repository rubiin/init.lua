-- enable lazyvim.plugins.extras.editor.harpoon2 first before using this override

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
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
          require("harpoon"):list():clear()
        end,
        desc = "Clear All",
      },
      {
        "<leader>hn",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Next File",
      },
      {
        "<leader>hp",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Previous File",
      },
    },
    init = function()
      -- disable harpoon's default keymaps
      Snacks.keymap.del("n", "<leader>H")
      Snacks.keymap.del("n", "<leader>h")
    end,
  },
}
