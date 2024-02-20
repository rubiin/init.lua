return {

  { import = "lazyvim.plugins.extras.lang.markdown" },
  -- Markdown preview
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>Glow<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      local ok, glow = pcall(require, "glow")
      if not ok then
        return
      end
      local config = {
        glow_install_path = "~/.local/bin", -- default path for installing glow binary
        style = "dark", -- filled automatically with your current editor background, you can override using glow json style
        pager = true,
      }
      glow.setup(config)
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    opts = function()
      local opts = {}
      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        opts[ft] = {
          headline_highlights = {},
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
}
