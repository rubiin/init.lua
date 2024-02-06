return {
  {
    "michaelb/sniprun",
    event = "VeryLazy",
    build = "bash ./install.sh",
    opts = {
      live_mode_toggle = "enable",
      display = {
        "VirtualText", --# display ok results as virtual text (multiline is shortened)
        "Terminal",
      },
      display_options = {
        terminal_scrollback = vim.o.scrollback,
      },
      live_display = { "VirtualText", "Terminal" },
    },
  },
}
