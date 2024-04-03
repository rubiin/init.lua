return {

  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "lukas-reineke/headlines.nvim",
    enabled = false,
  },
  -- Markdown preview
  {
    "MeanderingProgrammer/markdown.nvim",
    cmd = "RenderMarkdownToggle",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>RenderMarkdownToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      require("render-markdown").setup({})
    end,
  },
}
