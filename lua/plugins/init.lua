return {
  { import = "plugins.editor" },
  { import = "plugins.ui" },
  { import = "plugins.coding" },
  { import = "plugins.lsp" },
  { import = "plugins.local" },

  -- install from extras if you need them
  -- plugin.<file name without extension> to require it.
  { import = "plugins.extras.wakatime" },
  { import = "plugins.extras.better-escape" },
  { import = "plugins.extras.cybu" },
  { import = "plugins.extras.autosave" },
  { import = "plugins.extras.runner" },
  { import = "plugins.extras.dropbar" },

  -- language setup
  { import = "plugins.extras.lang.typescript" },
  -- manually set typescript server , options are extras.typescript-tools and extras.vtls
  { import = "plugins.extras.vtls" },
}
