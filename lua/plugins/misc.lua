return {
  {
    "sunjon/shade.nvim",
    event = "VeryLazy",
    config = function()
      require("shade").setup({
        overlay_opacity = 10,
        opacity_step = 1,
      })
      require("shade").toggle()
    end,
  },
  -- profiling vim startup
  {
    enabled = false,
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end
  },
  -- waka time
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy"
  },

  {
    "echasnovski/mini.misc",
    config = true,
    event = "VeryLazy",
    --stylua: ignore
    keys = {
      {
        "<leader>uz",
        function()
          require("mini.misc").zoom()
        end,
        desc = "Toggle Zoom"
      }
    }
  },
  {
    "rcarriga/nvim-notify",
    opts= {
      timeout = 2000,
    }
  }
}
