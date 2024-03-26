local keymap = vim.keymap.set

return {
  {
    "marilari88/twoslash-queries.nvim",
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
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
        if client.name == "typescript-tools" then
          keymap(
            "n",
            "<leader>la",
            "<cmd>TSToolsAddMissingImports<cr>",
            { buffer = bufnr, desc = "Add Missing Imports" }
          )
          keymap("n", "<leader>lo", "<cmd>TSToolsOrganizeImports<cr>", { buffer = bufnr, desc = "Organize Imports" })
          keymap("n", "<leader>lO", "<cmd>TSToolsSortImports<cr>", { buffer = bufnr, desc = "Sort Imports" })
          keymap("n", "<leader>lu", "<cmd>TSToolsRemoveUnused<cr>", { buffer = bufnr, desc = "Removed Unused" })
          keymap(
            "n",
            "<leader>lr",
            "<cmd>TSToolsRemoveUnusedImports<cr>",
            { buffer = bufnr, desc = "Removed Unused Imports" }
          )
          keymap(
            "n",
            "<leader>ld",
            "<cmd>TSToolsGoToSourceDefinition<cr>",
            { buffer = bufnr, desc = "Go To Source Definition" }
          )
          keymap("n", "<leader>lf", "<cmd>TSToolsFixAll<cr>", { buffer = bufnr, desc = "Fix All" })
          require("twoslash-queries").attach(client, bufnr)
        end
      end)
      require("typescript-tools").setup({})
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
            return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = LazyVim.lsp.formatter({
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
          LazyVim.format.register(formatter)
        end,
      },
    },
  },
}
