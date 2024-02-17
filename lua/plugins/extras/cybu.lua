return {
  "ghillb/cybu.nvim",
  cond = #vim.api.nvim_list_uis() > 0,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("cybu").setup({
      display_time = 500,
      position = {
        anchor = "centerright",
        max_win_height = 8,
        max_win_width = 0.5,
      },
      style = {
        border = "rounded",
        hide_buffer_id = true,
      },
      exclude = { -- filetypes
        "qf",
        "help",
      },
    })
  end,
}
