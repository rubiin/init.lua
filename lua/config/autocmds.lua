-- ========================================================================== --
-- ==                          AUTO COMMANDS                               == --
-- ========================================================================== --

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt_local, autocmd, fn, cmd, api = vim.opt_local, vim.api.nvim_create_autocmd, vim.fn, vim.cmd, vim.api

local constants = require("utils.constants")
local utils = require("utils")

local aufilewrite = utils.augroup("FileWrite")
local augeneral = utils.augroup("GeneralSettings")

-- Start git messages in insert mode
autocmd("FileType", {
  group = augeneral,
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

-- Start git messages in insert mode
autocmd("FileType", {
  group = augeneral,
  pattern = { "typescript" },
  callback = function()
    utils.keymap("n", "<C-a>", function()
      return require("dial.map").inc_normal("typescript")
    end, { expr = true, desc = "Increment" })
    utils.keymap("n", "<C-x>", function()
      return require("dial.map").dec_normal("typescript")
    end, { expr = true, desc = "Descrement" })
    utils.keymap("v", "<C-a>", function()
      return require("dial.map").inc_normal("typescript")
    end, { expr = true, desc = "Increment" })
    utils.keymap("v", "<C-x>", function()
      return require("dial.map").dec_normal("typescript")
    end, { expr = true, desc = "Increment" })
  end,
})

-- Fix comment, don't add comment on new line
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augeneral,
  pattern = "*",
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
  pattern = constants.exclude_file_types,
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

-- Hide cursor line when in insert mode or when leaving the window
autocmd({ "InsertEnter", "WinLeave" }, {
  group = augeneral,
  pattern = "*",
  command = "set nocursorline",
})

-- This autocmd sets the wrap and spell options to true for filetypes
autocmd("FileType", {
  group = augeneral,
  pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
  callback = function()
    opt_local.wrap = true
    opt_local.spell = true
  end,
})

-- Use the more sane snippet session leave logic. Copied from:
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

-- Disable swap/undo/backup files in temp directories or some files
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

-- Disable diagnostics in a .env file and node_modules (0 is current buffer only)
autocmd("BufRead", {
  group = augeneral,
  pattern = { ".env", "*/node_modules/*" },
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

-- Trim trailing whitespace and trailing blank lines on save
autocmd("BufWritePre", {
  group = utils.augroup("trim_on_save"),
  callback = utils.trim,
})

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = utils.augroup("terminalSetting"),
  pattern = "*",
  command = "startinsert | set winfixheight",
})

-- Disable foldcolumn and signcolumn for terminals
autocmd("TermOpen", {
  group = utils.augroup("terminalSetting"),
  pattern = "*",
  callback = function()
    opt_local.foldcolumn = "0"
    opt_local.signcolumn = "no"
    opt_local.number = false
  end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = utils.augroup("lazyvim_checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      cmd("checktime")
    end
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = utils.augroup("lazyvim_resize_splits"),
  callback = function()
    local current_tab = fn.tabpagenr()
    cmd("tabdo wincmd =")
    cmd("tabnext " .. current_tab)
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = utils.augroup("lazyvim_last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = api.nvim_buf_get_mark(buf, '"')
    local line_count = api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Fix conceallevel for specific files
autocmd({ "FileType" }, {
  group = utils.augroup("lazyvim_json_conceal"),
  pattern = { "json", "jsonc", "json5", "*.txt", "*.md" },
  callback = function()
    opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = utils.augroup("lazyvim_auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    fn.mkdir(fn.fnamemodify(file, ":p:h"), "p")
  end,
})

local fold_augroup = utils.augroup("remember_folds")

autocmd({ "BufLeave", "BufWinLeave" }, {
  pattern = "*",
  group = fold_augroup,
  callback = function()
    cmd("silent! mkview")
  end,
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
  pattern = constants.common_file_types,
  group = utils.augroup("DisableIndentScope"),
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
  desc = "Disable `mini.indentscope` for specific filetypes",
})

-- Disable caps lock while vim is running
autocmd("InsertEnter", {
  pattern = "*",
  group = utils.augroup("ToggleCapsLock"),
  command = "!setxkbmap -option",
})

autocmd("InsertLeave", {
  group = utils.augroup("ToggleCapsLock"),
  pattern = "*",
  command = "!setxkbmap -option ctrl:nocaps",
})

-- ========================================================================== --
-- ==                          USER COMMANDS                               == --
-- ========================================================================== --

local user_cmd = api.nvim_create_user_command

user_cmd("TrimTrailingLines", utils.trim_trailing_lines, {
  desc = "Trim trailing lines",
})

user_cmd("TrimWhitespace", utils.trim_trailing_whitespace, {
  desc = "Trim trailing whitespace",
})

user_cmd("ToggleDarkMode", utils.toggle_light_dark_theme, {
  desc = "Toggle dark mode",
})

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
user_cmd("Cwd", function()
  cmd(":cd %:p:h")
  cmd(":pwd")
end, { desc = "cd current file's directory" })

-- Set working directory (alias)
user_cmd("Swd", function()
  cmd(":cd %:p:h")
  cmd(":pwd")
end, { desc = "cd current file's directory" })

-- Write all buffers
user_cmd("WriteAllBuffers", function()
  cmd("wa")
end, { desc = "Write all changed buffers" })
