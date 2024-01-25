-- _   __ _______   ____  ___  ___  ______  _____
-- | | / /|  ___\ \ / /  \/  | / _ \ | ___ \/  ___|
-- | |/ / | |__  \ V /| .  . |/ /_\ \| |_/ /\ `--.
-- |    \ |  __|  \ / | |\/| ||  _  ||  __/  `--. \
-- | |\  \| |___  | | | |  | || | | || |    /\__/ /
-- \_| \_/\____/  \_/ \_|  |_/\_| |_/\_|    \____/

-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`

local lazyvim_util = require("lazyvim.util")
local del = vim.keymap.del
local keymap = require("utils.helpers").keymap

-- Add toggle gitsigns blame line
if lazyvim_util.has("gitsigns.nvim") then
  keymap("n", "<leader>uB", function()
    require("gitsigns").toggle_current_line_blame()
  end, {
    desc = "Toggle Current Line Blame",
  })
end

-- Delete LazyVim default bindings
del("n", "<leader>l")
del("n", "<leader>L")
del("n", "<leader>-")

-- Copy whole file content to clipboard with C-c
keymap("n", "<C-c>", ":%y+<CR>", { desc = "Copy whole file to clipboard" })

-- Select all text in buffer with C-a
keymap("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Move live up or down
keymap("n", "<A-Down>", ":m .+1<CR>", { desc = "Move line down" })
keymap("n", "<A-Up>", ":m .-2<CR>", { desc = "Move line up" })
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- keymap("n", "<leader>;", function()
--   require("dashboard"):instance()
-- end, { desc = "Open Dashboard" })

-- Add LazyVim bindings for meta information
keymap("n", "<leader>;m", "<cmd>Mason<CR>", { desc = "Package Manager - [Mason]" })
keymap("n", "<leader>;p", "<cmd>Lazy<CR>", { desc = "Plugin Manager - [LazyVim]" })
keymap("n", "<leader>;e", "<cmd>LazyExtras<CR>", { desc = "Extras Manager - [LazyVim]" })
keymap("n", "<leader>;l", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })
keymap("n", "<leader>;i", "<cmd>ConformInfo<CR>", { desc = "Conform Info" })
keymap("n", "<leader>;c", lazyvim_util.news.changelog, { desc = "Changelog [LazyVim]" })
keymap("n", "<leader>;M", vim.cmd.messages, { desc = "Display messages" })

-- Add spell check to cspell
keymap("n", "<leader>cs", function()
  require("utils.cspell").add_word_to_c_spell_dictionary()
end, { desc = "Add unknown to cspell dictionary" })

keymap("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", {
  desc = "Make it rain baby",
})

-- All Hail Lsp
keymap("n", "<leader>lo", function()
  require("telescope.builtin").lsp_document_symbols()
end, {
  desc = "Lsp Outline",
})

keymap("n", "<leader>li", function()
  require("telescope.builtin").lsp_incoming_calls()
end, {
  desc = "Lsp Incoming Calls",
})

keymap("n", "<leader>lo", function()
  require("telescope.builtin").lsp_outgoing_calls()
end, {
  desc = "Lsp Outgoing Calls",
})

-- Fun stuffs
keymap("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", {
  desc = "Make it rain baby",
})
