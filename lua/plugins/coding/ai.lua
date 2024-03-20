return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
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
      keymap = {
        accept = "<Tab>",
        close = "<Esc>",
        next = "<C-J>",
        prev = "<C-K>",
        select = "<CR>",
        dismiss = "<C-X>",
      },
    },
  },
}
