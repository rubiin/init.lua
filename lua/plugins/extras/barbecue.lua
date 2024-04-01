return {
  {
    "utilyre/barbecue.nvim",
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    enabled = function()
      return not require("utils").is_neovim_version_satisfied(10)
    end,
    opts = function()
      return {
        theme = "catppuccin",
        show_modified = true,
        kinds = require("custom.icons").kinds,
        create_autocmd = false,
      }
    end,
    config = function(_, opts)
      require("barbecue").setup(opts)
      -- auto update barbecue , more performant than using default autocmd
      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", { clear = true }),
        callback = function()
          local barbeque_ui = prequire("barbecue.ui")

          barbeque_ui.update()
        end,
      })
    end,
  },
}
