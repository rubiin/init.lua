local keys = { quit = { "<esc>", "q" }, toggle_or_jump = { "<cr>", "o" } }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {
          settings = {
            diagnosticSeverity = "Warning",
          },
        },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                checkThirdParty = false,
                maxPreload = 10000,
                preloadFileSize = 1000,
              },
              telemetry = { enable = false },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
    init = function()
      local keymaps = require("lazyvim.plugins.lsp.keymaps").get()
      keymaps[#keymaps + 1] = { "K", false }
      keymaps[#keymaps + 1] = { "<leader>ca", false }
      keymaps[#keymaps + 1] = { "<leader>cl", false }
      keymaps[#keymaps + 1] = { "<leader>cA", false }
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
      rename = { enable = true }, --  used telescope/inc-rename for this
      code_action = { enable = true, extend_gitsigns = true, show_server_name = true }, -- might use actions-preview for this

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
        desc = "Code action (source)",
      },

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

  -- TODO: remove unwanted codespell, misspell, proselint
}
