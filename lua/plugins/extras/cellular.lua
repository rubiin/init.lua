return {
  {
    "eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
    lazy = true,
    cmd = "CellularAutomaton",
    keys= {
      { "<leader>yc", "<cmd>CellularAutomaton game_of_life<cr>" , {desc= "Game of Life"}},
      { "<leader>yd", "<cmd>CellularAutomaton make_it_rain<cr>" , {desc= "Make It Rain Baby"}},
    }
  },
}
