return {
  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
    },
    config = function(_, options)
      require("refactoring").setup(options)
      require("telescope").load_extension("refactoring")
    end,
    keys = require("config.keymaps").refactoring,
  },
}
