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
        -- max_win_height = 8,
        -- max_win_width = 0.5,
      },
      style = {
        path = "relative", -- absolute, relative, tail (filename only)
        border = "rounded", -- single, double, rounded, none
        separator = " ", -- string used as separator
        prefix = "…", -- string used as prefix for truncated paths
        padding = 1, -- left & right padding in number of spaces
        hide_buffer_id = true,
      },
      devicons = {
        enabled = true, -- enable or disable web dev icons
        colored = true, -- enable color for web dev icons
      },
      exclude = {       -- filetypes
        "qf",
        "help",
      },
    })
  end,
}
