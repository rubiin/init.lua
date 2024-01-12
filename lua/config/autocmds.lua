--   ___  _   _ _____ _____ _____ ___  ________
--  / _ \| | | |_   _|  _  /  __ \|  \/  |  _  \
-- / /_\ \ | | | | | | | | | /  \/| .  . | | | |
-- |  _  | | | | | | | | | | |    | |\/| | | | |
-- | | | | |_| | | | \ \_/ / \__/\| |  | | |/ /
-- \_| |_/\___/  \_/  \___/ \____/\_|  |_/___/

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local api = vim.api
local opt_local = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd

local function augroup(name, opts)
	opts = opts or {}
	return vim.api.nvim_create_augroup(name, opts)
end

local function rubinaugroup(name)
	return augroup("rubiin_" .. name, { clear = true })
end


local patterns = {
	"dap-float",
	"fugitive",
	"fugitiveblame",
	"git",
	"help",
	"lspinfo",
	"man",
	"notify",
	"null-ls-info",
	"none-ls-info",
	"PlenaryTestPopup",
	"qf",
	"query", -- :InspectTree
	"spectre_panel",
	"startuptime",
	"tsplayground",
}





-- reload tmux on config save
autocmd("BufWritePost", {
  pattern = { "*tmux.conf" },
  command = "execute 'silent !tmux source <afile> --silent'",
})

-- reload zsh on save
autocmd("BufWritePost", {
  pattern = { ".zshrc", "*aliases" },
  command = "execute 'silent !source .zshrc --silent'",
})


-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("HighlightYank"),
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 400,
      on_visual = false,
    })
  end,
})

-- close some filetypes with just <q> key
autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern =patterns,
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})


-- show cursor line only in active window
local cursorGrp = augroup("CursorLine")
autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)


-- set mdx file to markdown
autocmd("BufEnter", {
  pattern = { "*.mdx" },
  group = augroup("Markdown Set Filetype", { clear = true }),
  callback = function()
    vim.cmd("setfiletype markdown")
  end,
})


autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "*.txt", "*.md", "*.tex", "*.typ" },
  callback = function()
    opt_local.wrap = true
    opt_local.spell = true
  end,
})

-- Disable swap/undo/backup files in temp directories or shm
autocmd("BufWritePre", {
	group = augroup("undo_disable"),
	pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
	callback = function(event)
		opt_local.undofile = false
		if event.file == "COMMIT_EDITMSG" or event.file == "MERGE_MSG" then
			opt_local.swapfile = false
		end
	end,
})

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = augroup("TrimWhiteSpaceGrp", { clear = true })
autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})


-- //FIXME Start insert mode and disable line numbers in terminal buffer.
-- autocmd("TermOpen", {
--   group = augroup("TerminalSettings", { clear = true }),
--   callback = function()
--     opt_local.number = false
--     opt_local.relativenumber = false
--   end,
-- })


