local keys_maps = { quit = { "<esc>", "q" }, toggle_or_jump = { "<cr>", "o" } }

local user_icons = require("custom.icons")

return {
  {
    "nvimdev/lspsaga.nvim",
    cmd = "Lspsaga",
    event = "BufReadPost",
    opts = {
      definition = { enable = true, silent = true, keys = { quit = keys_maps.quit } }, -- peek definition
      outline = { enable = true, silent = true, keys = keys_maps }, -- symbols outline
      lightbulb = { enable = true }, -- bulb as the name says
      hover = {
        enable = true,
        max_width = 0.45,
        max_height = 0.7,
        open_link = "gl",
        keys = { quit = keys_maps.quit },
      }, -- hover doc
      rename = { enable = true }, --  used telescope/inc-rename for this
      code_action = { enable = true, extend_gitsigns = true, show_server_name = true, only_in_cursor = false }, -- might use actions-preview for this
      ui = {
        theme = "round",
        border = vim.g.border_style,
        winblend = 0,
        expand = user_icons.ui.Expand,
        collapse = user_icons.ui.Collapse,
        preview = user_icons.ui.Preview,
        code_action = user_icons.diagnostics.Hint,
        diagnostic = user_icons.diagnostics.Debug,
        hover = user_icons.ui.Hover,
        kind = {},
      },
      --- disabled lspsaga features
      finder = { enable = false }, -- handled by telescope
      diagnostic = { enable = false }, -- used inlay hints for this
      callhierarchy = { enable = false }, -- use telescope for this incoming/outgoing calls
      symbol_in_winbar = { enable = false }, -- used barbeque for this
    },
    keys = require("config.keymaps").lspsaga,
  },
}
