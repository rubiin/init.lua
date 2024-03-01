local util = require("utils")

return {
  {
    "ghillb/cybu.nvim",
    cond = #vim.api.nvim_list_uis() > 0,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<C-S-Tab>", "<Plug>(CybuLastusedPrev)", desc = "CybuLastusedPrev" },
      { "<C-Tab>", "<Plug>(CybuLastusedNext)", desc = "CybuLastusedNext" },
    },
    config = function()
      require("cybu").setup({
        position = {
          anchor = "center",
          max_win_height = 8,
          max_win_width = 0.5,
        },
        style = {
          border = vim.g.border_style,
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
        display_time = 500,
        fallback = function()
          util.notify("Cybu: Not active in '" .. vim.bo.filetype .. "' filetype.", vim.log.levels.INFO, "Cybu")
        end,
      })
    end,
  },
}
