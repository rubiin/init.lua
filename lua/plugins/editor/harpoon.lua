return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = { "BufReadPre", "BufNewFile" },
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
      }
      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Go To Mark " .. i,
        })
      end
      return keys
    end,
  },
}
