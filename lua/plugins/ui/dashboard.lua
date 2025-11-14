local user_icons = require("rubin.icons")
local util = require("utils")
local logo = require("rubin.banners").dashboard()

return {
  {
    "folke/snacks.nvim",
    event = "VimEnter",
    opts = function()
      function Footer()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local info = {}
        local info1 = {
          "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
            .. " on "
            .. user_icons.ui.Neovim
            .. util.neovim_version()
            .. "\n"
            .. "\n",
        }

        table.insert(info, info1)

        if vim.g.fortune then
          local fortune = require("fortune").get_fortune()
          for i, line in ipairs(fortune) do
            if i == #fortune - 1 then
              table.insert(info, { "\n\n\t" })
            end
            table.insert(info, { line })
          end
        end

        return info
      end

      return {
        dashboard = {
          preset = {
            pick = nil,
            keys = {
              {
                icon = user_icons.ui.Search,
                key = "f",
                desc = "Find File",
                action = ":lua Snacks.dashboard.pick('files')",
              },
              { icon = user_icons.ui.FileBold, key = "n", desc = "New File", action = ":ene | startinsert" },
              {
                icon = user_icons.ui.FileOld,
                key = "g",
                desc = "Find Text",
                action = ":lua Snacks.dashboard.pick('live_grep')",
              },
              {
                icon = user_icons.ui.History,
                key = "r",
                desc = "Recent Files",
                action = ":lua Snacks.dashboard.pick('oldfiles')",
              },
              {
                icon = user_icons.ui.Project,
                key = "p",
                desc = "Projects",
                action = ":lua Snacks.picker.projects()",
              },
              {
                icon = user_icons.ui.Gear,
                key = "c",
                desc = "Config",
                action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
              },
              {
                icon = user_icons.ui.Sleep,
                key = "L",
                desc = "Lazy",
                action = ":Lazy",
                enabled = package.loaded.lazy ~= nil,
              },
              { icon = user_icons.ui.Exit, key = "q", desc = "Quit", action = ":qa" },
            },
            header = logo,
          },
          sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            { text = Footer() },
          },
        },
      }
    end,
  },
}
