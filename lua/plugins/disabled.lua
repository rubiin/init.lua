-- contains plugins that are disabled
-- add more plugins here if you want to disable them
local disable_plugins = require("utils.helpers").disable_plugins

return disable_plugins({
  "folke/tokyonight",
  "echasnovski/mini.pairs",
})
