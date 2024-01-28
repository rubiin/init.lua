local keys = { quit = { "<esc>", "q" }, toggle_or_jump = { "<cr>", "o" } }

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<leader>ca", false }
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    cmd = "Lspsaga",
    event = "BufReadPost",
    opts = {
      definition = { enable = true, silent = true, keys = { quit = keys.quit } }, -- peek definition
      outline = { enable = true, silent = true, keys = keys }, -- symbols outline
      lightbulb = { enable = true }, -- bulb as the name says
      hover = { enable = true, keys = { quit = keys.quit } }, -- hover doc
      code_action = { enable = true, extend_gitsigns = true, show_server_name = true }, -- might use actions-preview for this

      --- disabled lspsaga features
      finder = { enable = false }, -- handled by telescope
      rename = { enable = false }, --  used telescope/inc-rename for this
      diagnostic = { enable = false }, -- used inlay hints for this
      callhierarchy = { enable = false }, -- use telescope for this incoming/outgoing calls
      symbol_in_winbar = { enable = false }, -- used barbeque for this
    },
    keys = {
      { "<leader>cp", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      { "<leader>ca", "<Cmd>Lspsaga code_action<CR>", desc = "Code Action" },
      { "<leader>uo", "<Cmd>Lspsaga outline<CR>", desc = "Outline Toggle" },
      { "K", "<Cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
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
