return {
  { import = "plugins.editor" },
  { import = "plugins.ui" },
  { import = "plugins.coding" },
  { import = "plugins.lsp" },
  { import = "plugins.local" },
  { import = "plugins.overrides" },

  -- install from extras if you need them
  -- plugin.<file name without extension> to require it.
  { import = "plugins.extras.autosave" },
  { import = "plugins.extras.wakatime" },
}
