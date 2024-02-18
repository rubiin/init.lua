return {
  "ghillb/cybu.nvim",
  cond = #vim.api.nvim_list_uis() > 0,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "[b", "<Plug>(CybuPrev)" },
    { "]b", "<Plug>(CybuNext)" },
    { "<C-S-Tab>", "<Plug>(CybuLastusedPrev)" },
    { "<C-Tab>", "<Plug>(CybuLastusedNext)" },
  },
  config = function()
    require("cybu").setup({
      position = {
        anchor = "center",
        max_win_height = 8,
        max_win_width = 0.5,
      },
      style = {
        border = "rounded",
        path = "relative",
      },
      devicons = {
        enabled = true,
        colored = true,
      },
      exclude = { -- filetypes
        "qf",
        "help",
      },
      display_time = 750,
      fallback = function()
        vim.notify("Cybu: Not active in '" .. vim.bo.filetype .. "' filetype.", vim.log.levels.INFO)
      end,
    })
  end,
}
