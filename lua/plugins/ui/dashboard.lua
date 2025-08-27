local user_icons = require("rubin.icons")
local util = require("utils")

local fortune = require("fortune").get_fortune()
local logo = require("utils.banners").dashboard()

function footer()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local info = {}
            local info1 = {"⚡ Neovim loaded "
              .. stats.loaded
              .. "/"
              .. stats.count
              .. " plugins in "
              .. ms
              .. "ms"
              .. " on "
              .. user_icons.ui.Neovim
              .. util.neovim_version()
            }

            table.insert(info, info1)



            return info
end

print(footer())


return {
  {
    "folke/snacks.nvim",
    event = "VimEnter",
    opts = {
      dashboard = ---@class snacks.dashboard.Config
      ---@field enabled? boolean
      ---@field sections snacks.dashboard.Section
      ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
      {
        -- These settings are used by some built-in sections
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = user_icons.ui.Search,   key = 'f', desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
            { icon = user_icons.ui.FileBold, key = 'n', desc = "New File",        action = ":ene | startinsert" },
            { icon = user_icons.ui.FileOld,  key = 'g', desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = user_icons.ui.History,  key = 'r', desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = user_icons.ui.Gear,     key = 'c', desc = "Config",          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = user_icons.ui.History,  key = 's', desc = "Restore Session", section = "session" },
            { icon = user_icons.ui.Sleep,    key = 'L', desc = "Lazy",            action = ":Lazy",                                                                enabled = package.loaded.lazy ~= nil },
            { icon = user_icons.ui.Exit,     key = 'q', desc = "Quit",            action = ":qa" },
          },
          -- Used by the `header` section
          header = logo,
        },
        sections = {
          { section = "header" },
          { section = "keys",  gap = 1, padding = 1 },
          {
            align = "center",
            text = footer(),
          },
        },
      }
    }
  },
}
