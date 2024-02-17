return {
  -- zoom
  {
    "echasnovski/mini.misc",
    config = true,
    lazy = true,
    event = "VeryLazy",
      --stylua: ignore
    keys = require("config.keymaps").zoom,
  },
}
