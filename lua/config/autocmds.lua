--   ___  _   _ _____ _____ _____ ___  ________
--  / _ \| | | |_   _|  _  /  __ \|  \/  |  _  \
-- / /_\ \ | | | | | | | | | /  \/| .  . | | | |
-- |  _  | | | | | | | | | | |    | |\/| | | | |
-- | | | | |_| | | | \ \_/ / \__/\| |  | | |/ /
-- \_| |_/\___/  \_/  \___/ \____/\_|  |_/___/

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
	return vim.api.nvim_create_augroup("my_augroup_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})



-- close some filetypes with just <q> key
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query", -- :InspectTree
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"fugitiveblame",
		"git",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = augroup("wrap_spell"),
-- 	pattern = { "gitcommit", "markdown" },
-- 	callback = function()
-- 		vim.opt_local.wrap = true
-- 		vim.opt_local.spell = true
-- 	end,
-- })



-- local toggle_options = vim.api.nvim_create_augroup("ToggleOptions", { clear = true })

-- vim.api.nvim_create_autocmd("WinLeave", {
-- 	group = toggle_options,
-- 	desc = "unset cursorline",
-- 	command = "lua vim.opt.cursorline = false",
-- })

-- vim.api.nvim_create_autocmd("WinEnter", {
-- 	group = toggle_options,
-- 	desc = "set cursorline",
-- 	command = "lua vim.opt.cursorline = true",
-- })
