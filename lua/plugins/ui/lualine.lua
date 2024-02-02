-- use a protected call so we don't error out on first use
local status_ok, lualinestyles = pcall(require, "utils.helpers")
if not status_ok then
	print("please restart neovim")
	return
end

local lualine_styles = lualinestyles.lualine_styles

local used_style = lualine_styles.styles.slanted -- this is the default style, change it to the style you want to use from the list

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    lazy = true,
    opts = lualine_styles(used_style),
  },
}
