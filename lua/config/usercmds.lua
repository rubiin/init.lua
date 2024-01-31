-- ========================================================================== --
-- ==                          USER COMMANDS                               == --
-- ========================================================================== --
local lualine_picker = require("custom.lualinepicker")
Helpers = require("utils.helpers")

local user_command = vim.api.nvim_create_user_command

user_command("TrimTrailingLines", Helpers.trim_trailing_lines, {})

user_command("TrimWhitespace", Helpers.trim_trailing_whitespace, {})

user_command("LuaLineSelect", lualine_picker, {})

user_command("ToggleDarkMode", Helpers.toggle_light_dark_theme, {})

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
user_command("SetCWD", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", {})
