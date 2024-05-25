-- Load local plugins here
-- If you are not rubiin, replace dev=true with dev=false

return {
  {
    "rubiin/fortune.nvim",
    dev = true,
    event = "VimEnter",
    opts = {
      max_width = 60,
      content_type = "tips",
    },
  },
  {
    "rubiin/vimwordlist.nvim",
    cmd = "GenerateVimSpell",
    dev = true,
    build = "GenerateVimSpell",
    config = function()
      vim.opt.spelllang:append("vim")
      vim.opt.spelllang:append("programming") -- append personal wordlist to spelllang
    end,
  },
}
