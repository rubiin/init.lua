-- contains plugins that are disabled
-- add more plugins here if you want to disable them
local disable_plugins = require("utils").disable_plugins

return disable_plugins({
  "nvim-mini/mini.comment",
  "nvim-mini/mini.pairs",
  "folke/tokyonight.nvim",
  "folke/persistence.nvim",
})
