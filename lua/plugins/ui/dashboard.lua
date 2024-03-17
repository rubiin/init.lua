local lazy_util = require("lazyvim.util")
local user_icons = require("custom.icons")
local util = require("utils")

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = require("utils.banners").dashboard()
      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = lazy_util.telescope("files"), desc = ' Find File', icon = user_icons.ui.Search, key = 'f' },
            { action = 'ene | startinsert', desc = ' New File', icon = user_icons.ui.FileBold, key = 'n' },
            { action = 'Telescope oldfiles', desc = ' Recent Files', icon = user_icons.ui.FileOld, key = 'r' },
            { action = [[lua require('lazyvim.util').telescope.config_files()()]], desc = ' Config', icon = user_icons.ui.Gear, key = 'c' },
            { action = [[lua require('telescope').extensions.projects.projects()]], desc = " Projects", icon = user_icons.ui.Project, key = "P" },
            { action = 'SessionLoadLast', desc = ' Last Session', icon = user_icons.ui.History, key = 's' },
            { action = 'Lazy', desc = ' Lazy', icon = user_icons.ui.Sleep, key = 'p' },
            { action = 'Mason', desc = ' Mason', icon = user_icons.ui.PackageAdd, key = 'm' },
            { action = 'qa', desc = ' Quit', icon = user_icons.ui.Exit, key = 'q' },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local info = {}
            info[1] = "⚡ Neovim loaded "
              .. stats.loaded
              .. "/"
              .. stats.count
              .. " plugins in "
              .. ms
              .. "ms"
              .. " on "
              .. user_icons.ui.Neovim
              .. util.neovim_version()
            info[2] = ""

            if vim.g.fortune then
              local fortune = require("fortune").get_fortune()
              local footer = vim.list_extend(info, fortune)
            end

            return info
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
