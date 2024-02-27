-- Load local plugins here
-- If you are not rubiin, replace ~/personal-vim-plugs with rubiin
return {
  {
    dir = "~/personal-vim-plugs/fortune.nvim",
    lazy = true,
    event = "VimEnter",
    opts = {
      max_width = 60,
      content_type = "tips",
    },
  },
}
