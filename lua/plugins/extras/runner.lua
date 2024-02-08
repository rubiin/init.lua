return {
  {
    "michaelb/sniprun",
    event = "VeryLazy",
    build = "bash ./install.sh",
    opts = {
      live_mode_toggle = "enable",
      display = {
        "Terminal",
      },
      display_options = {
        terminal_scrollback = vim.o.scrollback,
        terminal_width = 80,
      },
      live_display = { "Terminal" },
    },
  },
}
