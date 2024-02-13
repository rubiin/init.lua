local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

local util = require("utils")

function M.config()
  require("oil").setup({
    float = {
      max_height = 20,
      max_width = 60,
    },
  })
  util.keymap("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Parent Directory" })
end

return M
