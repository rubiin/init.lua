-- ========================================================================== --
-- ==                          Key Maps                                    == --
-- ========================================================================== --
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`

local lazyvim_util = require("lazyvim.util")
local utils = require("utils")

utils.cowboy()

-- Add toggle gitsigns blame line
if lazyvim_util.has("gitsigns.nvim") then
  utils.keymap("n", "<leader>uB", function()
    require("gitsigns").toggle_current_line_blame()
  end, {
    desc = "Toggle Current Line Blame",
  })
end

-- Copy whole file content to clipboard with C-1
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

-- Add spell check to cspell
utils.keymap("n", "<leader>cs", function()
  require("utils.cspell").add_word_to_cspell_dictionary()
end, { desc = "Add Word To Cspell Dictionary" })

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
