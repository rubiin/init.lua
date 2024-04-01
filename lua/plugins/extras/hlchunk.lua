return {
  "shellRaining/hlchunk.nvim",
  event = { "UIEnter" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        notify = true,
        style = "#fabd2f",
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "─",
        },
        use_treesitter = false,
      },
      indent = {
        style = {
          "#504945",
        },
      },

      line_num = {
        enable = false,
        use_treesitter = false,
        style = "#ebdbb2",
      },

      blank = {
        enable = false,
      },
    })
  end,
}
