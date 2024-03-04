return {
  { "tpope/vim-sleuth", event = "VeryLazy" }, -- This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
  { "tpope/vim-repeat", event = "VeryLazy" }, -- This plugin enables . repeat support on some plugins
  { "ThePrimeagen/vim-be-good", event = "VeryLazy" }, -- This plugin is a game to help you get better at Vim
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
}

-- TODO: vim-fugitive
