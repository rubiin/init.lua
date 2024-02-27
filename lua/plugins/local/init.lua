-- Load local plugins here
-- If you are not rubiin, replace ~/personal-vim-plugs with rubiin
return {
  {
    "~/personal-vim-plugs/fortune.nvim",
    lazy = true,
    event = "VimEnter",
    enabled = function()
      return vim.g.fortune
    end,
    opts = {
      max_width = 60,
      content_type = "tips",
    },
  },
}
