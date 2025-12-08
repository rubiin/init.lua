local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local user_icons = require("rubin.icons")

if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "catppuccin",
        defaults = {
          autocmds = false,
        },
      },
    },
    -- import/override with your plugins
    { import = "plugins" },
  },
  rocks = {
    enabled = false, -- don't use luarocks
  },
  ui = {
    title = "Plugin Manager",
    wrap = true,
    icons = {
      loaded = user_icons.ui.Loaded,
      not_loaded = user_icons.ui.NotLoaded,
    },
    border = vim.g.border_style,
  },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = '*', -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catpuccin" } },
  dev = { path = "~/personal/vim" },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = false, -- done on my own to use minimum condition for less noise
    frequency = 60 * 60 * 4, -- = 4 hours
  },
  performance = {
    rtp = {
      -- disable some rtp plugins, reference from NvChad
      disabled_plugins = {
        "rplugin", -- needed when using `:UpdateRemotePlugins` (e.g. magma.nvim)
        "matchparen",
        "matchit",
        "netrwPlugin",
        "man",
        "tutor",
        "health",
        "tohtml",
        "gzip",
        "zipPlugin",
        "tarPlugin",
      },
    },
  },
})

local function checkForPluginUpdates()
  if not require("lazy.status").has_updates() then
    return
  end
  local threshold = 5
  local numberOfUpdates = tonumber(require("lazy.status").updates():match("%d+"))
  if numberOfUpdates < threshold then
    return
  end
  vim.notify(("󱧕 %s plugin updates"):format(numberOfUpdates, vim.log.levels.INFO, {
    title = "Lazy",
    timeout = 2000,
  }))
end

vim.defer_fn(checkForPluginUpdates, 5000)
