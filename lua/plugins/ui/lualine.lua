-- use a protected call so we don't error out on first use
local success, lualinestyles = pcall(require, "utils")

if not success then
  print("Error loading 'utils':", lualinestyles)
  -- Additional error handling code
end
local used_style = lualinestyles.styles.slanted -- this is the default style, change it to the style you want to use from the list
local lualine_styles = lualinestyles.lualine_styles(used_style)

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    lazy = true,
    opts = lualine_styles,
  },
}

-- TODO: make the filetype Captial
