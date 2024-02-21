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
}