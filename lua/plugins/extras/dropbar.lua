return {
  {
    "Bekaboo/dropbar.nvim",
    event = "LazyFile",
    lazy = true,
    enabled = function()
      return require("utils").is_neovim_version_satisfied(10)
    end,
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = {},
  },
}
