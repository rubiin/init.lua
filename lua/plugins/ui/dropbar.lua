return {
  {
    "Bekaboo/dropbar.nvim",
    enabled = function()
      return require("utils.helpers").is_neovim_version_satisfied(10)
    end,
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = {},
  },
}
