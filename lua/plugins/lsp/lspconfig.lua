return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- if you use native lsp, you can use the following. Otherwise, its pretty much handled by lspsaga
      float = {
        focus = false,
        focusable = false,
        style = "minimal",
        border = "shadow",
        source = "always",
        header = "",
        prefix = "",
      },
      servers = {
        typos_lsp = {
          settings = {
            diagnosticSeverity = "information",
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
              diagnostics = {
                globals = { "vim", "spec" },
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
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
}
