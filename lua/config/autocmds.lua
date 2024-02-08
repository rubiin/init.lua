-- ========================================================================== --
-- ==                          AUTO COMMANDS                               == --
-- ========================================================================== --

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt_local, autocmd, fn, cmd, api = vim.opt_local, vim.api.nvim_create_autocmd, vim.fn, vim.cmd, vim.api

local utils = require("utils")

-- autoheader for sh scripts
require("custom.autoheader")

-- autogroup function
--- @param name string
---@param opts table?
local function augroup(name, opts)
  opts = opts or { clear = true }
  return api.nvim_create_augroup(name, opts)
end

local aufilewrite = augroup("FileWrite")
local augeneral = augroup("GeneralSettings")

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
  "lir",
  "DressingSelect",
  "Jaq",
}

-- Start git messages in insert mode
autocmd("FileType", {
  group = augeneral,
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

-- Fix comment, dont add comment on new line
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augeneral,
  pattern = { "*" },
  callback = function()
    cmd([[set formatoptions-=cro]])
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augeneral,
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 400,
      on_visual = false,
    })
  end,
})

-- Close some filetypes with just <q> key
-- Also disable number and cursorline
autocmd("FileType", {
  group = augeneral,
  pattern = patterns,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.o.number = false
    opt_local.cursorline = false
    utils.keymap("n", "q", "<cmd>close<cr>")
  end,
})

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  group = augeneral,
  pattern = "*",
  command = "set cursorline",
})

autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = augeneral })

-- This autocmd sets the wrap and spell options to true for filetypes
autocmd("FileType", {
  group = augeneral,
  pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
  callback = function()
    opt_local.wrap = true
    opt_local.spell = true
  end,
})

-- Disable swap/undo/backup files in temp directories or shm
autocmd("BufWritePre", {
  group = augeneral,
  pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
  callback = function(event)
    opt_local.undofile = false
    if event.file == "COMMIT_EDITMSG" or event.file == "MERGE_MSG" then
      opt_local.swapfile = false
    end
  end,
})

-- Show `` in specific files
autocmd({ "BufRead", "BufNewFile" }, {
  group = augeneral,
  pattern = { "*.txt", "*.md", "*.json" },
  command = "setlocal conceallevel=0",
})

-- Disable diagnostics in a .env file and node_modules (0 is current buffer only)
autocmd("BufRead", {
  group = augeneral,
  pattern = { ".env", "*/node_modules/*" },
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

-- Reload tmux on config save
autocmd("BufWritePost", {
  group = aufilewrite,
  pattern = { "*tmux.conf" },
  command = "!tmux source <afile>;notify-send -i reload 'Reloading tmux'",
})

-- Reload zsh on save
autocmd("BufWritePost", {
  group = aufilewrite,
  pattern = { ".zshrc", ".bash_aliases", ".zshenv" },
  command = "!source .zshrc;notify-send -i reload 'Reloading zshrc'",
})

-- Reload bash on save
autocmd("BufWritePost", {
  group = aufilewrite,
  pattern = { ".bashrc", ".bash_aliases", ".bashenv" },
  command = "!source .bashrc;notify-send -i reload 'Reloading bashrc'",
})

-- Trim trailing whitespace and trailing blank lines on save
autocmd("BufWritePre", {
  group = augroup("trim_on_save"),
  callback = utils.trim,
})

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = augroup("terminalSetting"),
  pattern = "*",
  command = "startinsert | set winfixheight",
})

-- Disable foldcolumn and signcolumn for terinals
autocmd("TermOpen", {
  group = augroup("terminalSetting"),
  pattern = "*",
  callback = function()
    opt_local.foldcolumn = "0"
    opt_local.signcolumn = "no"
    opt_local.number = false
  end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("lazyvim_checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      cmd("checktime")
    end
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("lazyvim_resize_splits"),
  callback = function()
    local current_tab = fn.tabpagenr()
    cmd("tabdo wincmd =")
    cmd("tabnext " .. current_tab)
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("lazyvim_last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = api.nvim_buf_get_mark(buf, '"')
    local lcount = api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
  group = augroup("lazyvim_json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("lazyvim_auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    fn.mkdir(fn.fnamemodify(file, ":p:h"), "p")
  end,
})

local fold_augroup = augroup("remember_folds")

autocmd({ "BufLeave", "BufWinLeave" }, {
  pattern = "*",
  callback = function()
    cmd("silent! mkview")
  end,
  group = fold_augroup,
  desc = "Remember folds on buffer exit",
})

autocmd("BufReadPost", {
  pattern = "*",
  group = fold_augroup,
  callback = function()
    cmd("silent! loadview")
  end,
  desc = "Restore folds on buffer enter",
})

-- Disable `mini.indentscope` for specific filetypes
autocmd("FileType", {
  pattern = { "fzf", "lspinfo" },
  group = augroup("DisableIndentScope"),
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
  desc = "Disable `mini.indentscope` for specific filetypes",
})

-- Disable caps lock while vim is running
autocmd("InsertEnter", {
  pattern = "*",
  group = augroup("ToggleCapsLock"),
  command = "!setxkbmap -option",
})

autocmd("InsertLeave", {
  group = augroup("ToggleCapsLock"),
  pattern = "*",
  command = "!setxkbmap -option ctrl:nocaps",
})

-- ========================================================================== --
-- ==                          USER COMMANDS                               == --
-- ========================================================================== --

local user_command = api.nvim_create_user_command

user_command("TrimTrailingLines", utils.trim_trailing_lines, {})

user_command("TrimWhitespace", utils.trim_trailing_whitespace, {})

user_command("ToggleDarkMode", utils.toggle_light_dark_theme, {})

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
user_command("SetCWD", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", {})

