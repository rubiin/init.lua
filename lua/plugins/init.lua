return {
  { import = "plugins.editor" },
  { import = "plugins.ui" },
  { import = "plugins.coding" },
  { import = "plugins.lsp" },
  { import = "plugins.local" },

  -- install from extras if you need them
  -- plugin.<file name without extension> to require it.
  { import = "plugins.extras.wakatime" },
  { import = "plugins.extras.barbecue" },
  { import = "plugins.extras.better-escape" },
  { import = "plugins.extras.zen" },
  { import = "plugins.extras.cybu" },
  { import = "plugins.extras.autosave" },

  -- language setup
  { import = "plugins.extras.lang.sh" },
  { import = "plugins.extras.lang.typescript" },
  { import = "plugins.extras.lang.markdown" },
}
