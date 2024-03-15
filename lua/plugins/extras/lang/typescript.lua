local keymap = vim.keymap.set

return {
  {
    "marilari88/twoslash-queries.nvim",
    lazy = true,
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    lazy = true,
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },

  {
    "David-Kunz/cmp-npm",
    event = "VeryLazy",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "json",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "tsx", "javascript", "typescript" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        -- formatters & linters
        "eslint_d",
        "prettier",
        "prettierd",
        "biome",
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    lazy = true,
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local api = require("typescript-tools.api")
      require("lazyvim.util.lsp").on_attach(function(client, bufnr)
        if client.name == "tsserver" then
          keymap(
            "n",
            "<leader>lA",
            "<cmd>TSToolsAddMissingImports<cr>",
            { buffer = bufnr, desc = "Add Missing Imports" }
          )
          keymap("n", "<leader>lo", "<cmd>TSToolsOrganizeImports<cr>", { buffer = bufnr, desc = "Organize Imports" })
          keymap("n", "<leader>lO", "<cmd>TSToolsSortImports<cr>", { buffer = bufnr, desc = "Sort Imports" })
          keymap("n", "<leader>lu", "<cmd>TSToolsRemoveUnused<cr>", { buffer = bufnr, desc = "Removed Unused" })
          keymap(
            "n",
            "<leader>lR",
            "<cmd>TSToolsRemoveUnusedImports<cr>",
            { buffer = bufnr, desc = "Removed Unused Imports" }
          )
          keymap(
            "n",
            "<leader>lz",
            "<cmd>TSToolsGoToSourceDefinition<cr>",
            { buffer = bufnr, desc = "Go To Source Definition" }
          )

          keymap("n", "<leader>lF", "<cmd>TSToolsFixAll<cr>", { buffer = bufnr, desc = "Fix All" })
          require("twoslash-queries").attach(client, bufnr)
        end
      end)
      require("typescript-tools").setup({

        settings = {
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = true,
          -- "change"|"insert_leave" determine when the client asks the server about diagnostic
          publish_diagnostic_on = "insert_leave",
          -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
          -- "remove_unused_imports"|"organize_imports") -- or string "all"
          -- to include all supported code actions
          -- specify commands exposed as code_actions
          expose_as_code_action = { "all" },
          tsserver_path = nil,
          tsserver_plugins = {},
          tsserver_max_memory = "auto",
          tsserver_format_options = {},

          -- locale of all tsserver messages, supported locales you can find here:
          -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
          tsserver_locale = "en",
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          -- CodeLens
          -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          code_lens = "off",
          -- by default code lenses are displayed on all referenceable values and for some of you it can
          -- be too much this option reduce count of them by removing member references from lenses
          disable_member_code_lens = true,
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "non-relative",
          },
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- other settings removed for brevity
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
          local function get_client(buf)
            return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = require("lazyvim.util").lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          require("lazyvim.util").format.register(formatter)
        end,
      },
    },
  },
}
