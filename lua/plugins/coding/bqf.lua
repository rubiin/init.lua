return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    cmd = "BqfAutoToggle",
    event = "VeryLazy",
    opts = {
      auto_enable = true,
      magic_window = true,
      auto_resize_height = false,
      preview = {
        auto_preview = false,
        show_title = true,
        delay_syntax = 50,
        win_height = 12,
        win_vheight = 12,
        wrap = false,
        border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
      },
      func_map = {
        tab = "t",
        openc = "o",
        drop = "O",
        split = "s",
        vsplit = "v",
        stoggleup = "M",
        stoggledown = "m",
        filterr = "f",
        stogglevm = "m",
        filter = "F",
        prevhist = "<",
        nexthist = ">",
        sclear = "c",
        ptoggleitem = "p",
        ptoggleauto = "a",
        ptogglemode = "P",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },
}

-- TODO: look into this plugin
