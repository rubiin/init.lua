local user_icons = require("rubin.icons")

return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        icons = {
          package_installed = user_icons.ui.Loaded,
          package_pending = user_icons.ui.Pending,
          package_uninstalled = user_icons.ui.NotLoaded,
        },
        border = vim.g.border_style,
        height = 0.8,
      }

      opts.max_concurrent_installers = 10

      -- Ensure these tools are installed, this includes only tools not installed globally
      -- if any tool is installed globally, remove from this list
      vim.list_extend(opts.ensure_installed or {}, {
        "selene",
        "biome",
        -- rustywind for tailwindcss
        "rustywind",
      })
    end,
  },
}
