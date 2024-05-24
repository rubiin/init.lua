-- contains plugins that are disabled
-- add more plugins here if you want to disable them
local disable_plugins = require("utils").disable_plugins

return disable_plugins({
  "folke/tokyonight",
  "echasnovski/mini.comment",
  "echasnovski/mini.pairs",
  "iamcco/markdown-preview.nvim",
})
