return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        ["*"] = false,
        yaml = false,
        markdown = true,
        help = true,
        go = true,
        html = true,
        javascript = true,
        lua = true,
        python = true,
        rust = true,
      },
    },
  },
}
