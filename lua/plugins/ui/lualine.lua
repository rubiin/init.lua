-- use a protected call so we don't error out on first use
local status_ok, lualinestyles = pcall(require, "utils.helpers")
if not status_ok then
	print("Please restart neovim after setup")
	return
end



local used_style = lualinestyles.styles.slanted -- this is the default style, change it to the style you want to use from the list
local lualine_styles = lualinestyles.lualine_styles(used_style)

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    lazy = true,
    opts = lualine_styles,
  },
}
