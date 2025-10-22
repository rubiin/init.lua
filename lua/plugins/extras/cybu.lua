local util = require("utils")

return {
  {
    "ghillb/cybu.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<C-S-Tab>", "<Plug>(CybuLastusedPrev)", mode = { "n", "v" }, desc = "CybuLastusedPrev" },
      { "<C-Tab>", "<Plug>(CybuLastusedNext)", mode = { "n", "v" }, desc = "CybuLastusedNext" },
    },
    opts = {
      position = {
        anchor = "center",
        max_win_height = 8,
        max_win_width = 0.5,
      },
      style = {
        border = vim.g.boder_style,
        path = "relative",
      },
      devicons = {
        enabled = true,
        colored = true,
      },
      exclude = {
        -- filetypes
        "qf",
        "help",
      },
      display_time = 800,
      fallback = function()
        util.notify("Cybu: Not active in '" .. vim.bo.filetype .. "' filetype.", vim.log.levels.INFO, "Cybu")
      end,
    },
  },
}
