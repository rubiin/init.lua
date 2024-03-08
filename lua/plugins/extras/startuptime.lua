return {
  -- profiling vim startup
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    lazy = true,
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
