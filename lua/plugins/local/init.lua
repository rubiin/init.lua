-- Load local plugins here
-- If you are not rubiin, replace dev=true with dev=false

return {
  {
    "rubiin/goodies.nvim",
    dev = true,
    event = "BufRead",
    opts = {
      author = {
        email = "roobin.bhandari@gmail.com",
        github = "rubiin",
        twitter = "RubinCodes",
        name = "Rubin Bhandari",
      },
    },
    keys = {
      -- Add Horizontal Comment Line
      {
        "hr",
        function()
          require("goodies").comment_hr()
        end,
        desc = "Add Horizontal Comment Line",
        mode = "n",
      },
      -- Open URL under cursor
      {
        "gx",
        function()
          require("goodies").open_url()
        end,
        desc = "Open URL Under Cursor",
        mode = "n",
      },
      -- Open Regex at Regex101
      {
        "<leader>yx",
        function()
          require("goodies").open_at_regex_101()
        end,
        desc = "Open Regex At Regex101",
        mode = "n",
      },
      -- Add Author Details
      {
        "<leader>yy",
        function()
          require("goodies").add_author_details()
        end,
        desc = "Add Author Details",
        mode = "n",
      },
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
    "rubiin/highlighturl.nvim",
    dev = true,
    event = "BufEnter", -- load when entering a buffer
    config = true,
  },
  {
    "rubiin/vimwordlist.nvim",
    dev = true,
    cmd = "GenerateVimSpell",
    build = ":GenerateVimSpell",
    config = function()
      vim.opt.spelllang:append("vim")
    end,
  },
}
