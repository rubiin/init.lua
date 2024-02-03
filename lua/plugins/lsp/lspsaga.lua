local keys = { quit = { "<esc>", "q" }, toggle_or_jump = { "<cr>", "o" } }
local user_icons = require("utils.icons")

return {

  {
    "nvimdev/lspsaga.nvim",
    cmd = "Lspsaga",
    event = "BufReadPost",
    opts = {
      definition = { enable = true, silent = true, keys = { quit = keys.quit } }, -- peek definition
      outline = { enable = true, silent = true, keys = keys }, -- symbols outline
      lightbulb = { enable = true }, -- bulb as the name says
      hover = { enable = true, keys = { quit = keys.quit } }, -- hover doc
      rename = { enable = true }, --  used telescope/inc-rename for this
      code_action = { enable = true, extend_gitsigns = true, show_server_name = true }, -- might use actions-preview for this
      ui = {
        theme = "round",
        border = "rounded",
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
    keys = {
      { "<leader>cp", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      { "<leader>ca", "<Cmd>Lspsaga code_action<CR>", desc = "Code Action" },
      {
        "<leader>cA",
        function()
          require("lspsaga.codeaction").code_action({ context = { only = "source" } })
        end,
        desc = "Code Action (Source)",
      },

      { "<leader>uo", "<Cmd>Lspsaga outline<CR>", desc = "Outline Toggle" },
      { "K", "<Cmd>Lspsaga hover_doc ++silent<CR>", desc = "Hover Doc" },
    },
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = {
        "sagafinder",
        "sagacallhierarchy",
        "sagaincomingcalls",
        "sagapeekdefinition",
        "sagaoutline",
      },
    },
  },
}
