-- _   __ _______   ____  ___  ___  ______  _____
-- | | / /|  ___\ \ / /  \/  | / _ \ | ___ \/  ___|
-- | |/ / | |__  \ V /| .  . |/ /_\ \| |_/ /\ `--.
-- |    \ |  __|  \ / | |\/| ||  _  ||  __/  `--. \
-- | |\  \| |___  | | | |  | || | | || |    /\__/ /
-- \_| \_/\____/  \_/ \_|  |_/\_| |_/\_|    \____/


-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local lazyvim_util = require("lazyvim.util")
local keymap = vim.keymap.set

local del = vim.keymap.del


keymap("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })
keymap("n", "<leader>ua", ":ASToggle<CR>", { desc = "Toggle Auto Save" })

-- Add toggle gitsigns blame line
if lazyvim_util.has("gitsigns.nvim") then
  keymap("n", "<leader>ub", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", {
    desc = "Toggle current line blame",
  })
end

-- Lazy Format Info
keymap("n", "<leader>fI", "<cmd>LazyFormatInfo<CR>", {
  desc = "Lazy Format Info",
})





-- Delete LazyVim default bindings for meta information
del("n", "<leader>l")
del("n", "<leader>L")

keymap("n", "<leader>;P", "<cmd>Mason<CR>", { desc = "Package Manager - [Mason]" })
keymap("n", "<leader>;p", "<cmd>Lazy<CR>", { desc = "Plugin Manager - [LazyVim]" })
keymap("n", "<leader>;e", "<cmd>LazyExtras<CR>", { desc = "Extras Manager - [LazyVim]" })
keymap("n", "<leader>;i", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })
keymap("n", "<leader>;c", lazyvim_util.news.changelog, { desc = "Changelog [LazyVim]" })
keymap("n", "<leader>;r", lazyvim_util.root.info, { desc = "Root Info [LazyVim]" })
keymap("n", "<leader>;M", vim.cmd.messages, { desc = "Display messages" })
