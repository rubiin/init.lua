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
    build = function()
      require("vimwordlist").update_spell_file()
    end,
    config = function()
      vim.opt.spelllang:append("vim")
    end,
  },
  {
    "rubiin/highlighturl.nvim",
    event = "BufReadPre",
    dev = true,
  },
}
