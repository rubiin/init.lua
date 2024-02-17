return {
  {
    "eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
    lazy = true,
    cmd = "CellularAutomaton",
    keys = require("config.keymaps").cellular_automaton,
  },
}
