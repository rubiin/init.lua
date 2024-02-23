-- ========================================================================== --
-- ==                          Key Maps                                    == --
-- ========================================================================== --
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`

local lazyvim_util = require("lazyvim.util")
local utils = require("utils")

utils.cowboy()

utils.keymap("n", "<C-1>", ":%y+<CR>", { desc = "Copy Whole File To Clipboard" })

-- Select all text in buffer with C-2
utils.keymap("n", "<C-2>", "ggVG", { desc = "Select All" })

-- Add LazyVim bindings for meta information
utils.keymap("n", "<leader>;m", "<cmd>Mason<CR>", { desc = "Package Manager - [Mason]" })
utils.keymap("n", "<leader>;p", "<cmd>Lazy<CR>", { desc = "Plugin Manager - [LazyVim]" })
utils.keymap("n", "<leader>;e", "<cmd>LazyExtras<CR>", { desc = "Extras Manager - [LazyVim]" })
utils.keymap("n", "<leader>;l", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })
utils.keymap("n", "<leader>;i", "<cmd>ConformInfo<CR>", { desc = "Conform Info" })
utils.keymap("n", "<leader>;c", lazyvim_util.news.changelog, { desc = "Changelog [LazyVim]" })
utils.keymap("n", "<leader>;M", vim.cmd.messages, { desc = "Display Messages" })

-- Override LazyVim bindings for terminal
utils.keymap("n", "<C-/>", function()
  lazyvim_util.terminal(nil, { border = vim.g.border_style })
end, { desc = "Terminal (Root Dir)" })

-- Search for TODO:|HACK:|WARN:|PERF:|FIX:|NOTE:|TEST:
utils.keymap("n", "<leader>ct", function()
  utils.search_todos()
end, { desc = "List Todos On QuickFix" })

-- Add keymap to open URL under cursor
utils.keymap("n", "gx", function()
  utils.open_url()
end, { desc = "Open URL Under Cursor" })

utils.keymap("n", "z=", function()
  require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
end, { desc = "Open URL Under Cursor" })

utils.keymap("n", "xx", function()
  require("telescope").extensions.custom.icon_picker()
end, { desc = "Icon picker" })
