local util = require("utils")

return {
  {
    "David-Kunz/cmp-npm",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "json",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = {
      "tsx",
      "javascript",
      "typescript",
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPost *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local api = require("typescript-tools.api")
      require("typescript-tools").setup({
        handlers = {
          ["textDocument/publishDiagnostics"] = api.filter_diagnostics(
            -- Ignore 'This may be converted to an async function' diagnostics.
            { 6133 }
          ),
        },
        settings = {
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = true,
          expose_as_code_action = "all",
          -- tsserver_plugins = {},
          tsserver_max_memory = "auto",
          -- complete_function_calls = true,
          include_completions_with_insert_text = true,
          -- code_lens = "all",
          -- disable_member_code_lens = true,

          -- described below
          -- tsserver_format_options = {},
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "non-relative",
            importModuleSpecifierEnding = "auto",
            includeInlayParameterNameHints = "all", -- "none" | "literals" | "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
            -- autoImportFileExcludePatterns = { "node_modules/*", ".git/*" },
          },
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })

      util.keymap("n", "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize Imports" })
      util.keymap("n", "<leader>cR", "<cmd>TSToolsRemoveUnusedImports<cr>", { desc = "Remove Unused Imports" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- other settings removed for brevity
    opts = {
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
}
