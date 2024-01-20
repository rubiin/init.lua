return {
  {
    'ThePrimeagen/refactoring.nvim',
    event = 'BufRead',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    keys= {
      { "<leader>rs", function() require("telescope").extensions.refactoring.refactors() end, mode = { "v" }, desc = "Refactor", },
      { "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, mode = {"n","v"}, desc =  "Inline Variable" },
      { "<leader>rb", function() require('refactoring').refactor('Exract Block') end, mode = {"n"}, desc = "Extract Block" },
      { "<leader>rf", function() require('refactoring').refactor('Exract Block To File') end, mode = {"n"}, desc = "Extract Block to File" },
      { "<leader>rP", function() require('refactoring').debug.printf({below = false}) end,  mode = {"n"}, desc = "Debug Print" },
      { "<leader>rp", function() require('refactoring').debug.print_var({normal = true}) end, mode = {"n"}, desc = "Debug Print Variable" },
      { "<leader>rc", function() require('refactoring').debug.cleanup({}) end, mode = {"n"}, desc = "Debug Cleanup" },
      { "<leader>rf", function() require('refactoring').refactor('Extract Function') end,  mode = {"v"}, desc = "Extract Function" },
      { "<leader>rF", function() require('refactoring').refactor('Extract Function to File') end, mode = {"v"}, desc =  "Extract Function to File" },
      { "<leader>rx", function() require('refactoring').refactor('Extract Variable') end, mode = {"v"}, desc = "Extract Variable" },
      { "<leader>rp", function() require('refactoring').debug.print_var({}) end, mode = {"v"}, desc =  "Debug Print Variable" },
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
      require('refactoring').setup(options)
      require('telescope').load_extension('refactoring')
    end,
  },
}
