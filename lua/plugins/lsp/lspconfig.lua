return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- if you use native lsp, you can use the following. Otherwise, its pretty much handled by lspsaga
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
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
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
                workspaceWord = true,
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
