-- Load local plugins here
-- If you are not rubiin, replace dev=true with dev=false

return {
  {
    "rubiin/goodies.nvim",
    dev = true,
    keys = {
      -- Add Horizontal Comment Line
      {
        "hr",
        function()
          require("goodies.utils").comment_hr()
        end,
        desc = "Add Horizontal Comment Line",
        mode = "n",
      },
      -- Open URL under cursor
      {
        "gx",
        function()
          require("goodies.utils").open_url()
        end,
        desc = "Open URL Under Cursor",
        mode = "n",
      },
      -- Open Regex at Regex101
      {
        "<leader>yx",
        function()
          require("goodies.utils").open_at_regex_101()
        end,
        desc = "Open Regex At Regex101",
        mode = "n",
      },
      -- Add Author Details
      -- {
      --   "<leader>yy",
      --   function()
      --     require("goodies.utils").add_author_details()
      --   end,
      --   desc = "Add Author Details",
      --   mode = "n",
      -- },
    },
  },
  {
    "rubiin/fortune.nvim",
    dev = true,
    event = "VimEnter",
    opts = {
      max_width = 40,
      content_type = "tips",
    },
  },
  {
    "rubiin/vimwordlist.nvim",
    cmd = "GenerateVimSpell",
    dev = true,
    build = ":GenerateVimSpell",
    config = function()
      vim.opt.spelllang:append("vim")
      vim.opt.spelllang:append("programming") -- append personal wordlist to spelllang
    end,
  },
}
