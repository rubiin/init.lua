-- Load local plugins here
-- If you are not rubiin, replace dev=true with dev=false

return {
  {
    "rubiin/fortune.nvim",
    lazy = true,
    dev = true,
    event = "VimEnter",
    opts = {
      max_width = 60,
      content_type = "tips",
    },
  },
  {
    "rubiin/vimwordlist.nvim",
    lazy = true,
    cmd = "GenerateVimSpell",
    build = ":GenerateVimSpell",
    config = function()
      vim.opt.spelllang:append("vim")
    end,
  },

}
