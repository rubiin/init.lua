local constants = require("utils.constants")
local utils = require("utils")

return {
  {
    "ghillb/cybu.nvim",
    event = "LazyFile",
    keys = {
      { "<C-S-Tab>", "<Plug>(CybuLastusedPrev)", mode = { "n", "v" }, desc = "CybuLastusedPrev" },
      { "<C-Tab>", "<Plug>(CybuLastusedNext)", mode = { "n", "v" }, desc = "CybuLastusedNext" },
    },
    opts = {
      position = {
        anchor = "center",
        max_win_height = 8,
        max_win_width = 0.5,
      },
      style = {
        border = vim.g.boder_style,
        path = "relative",
      },
      exclude = constants.common_file_types,
      display_time = 800,
      fallback = function()
        Snacks.notify.info("Cybu: Not active in '" .. vim.bo.filetype .. "' filetype.", vim.log.levels.INFO, "Cybu")
      end,
    },
  },
}
