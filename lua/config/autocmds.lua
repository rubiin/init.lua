--   ___  _   _ _____ _____ _____ ___  ________
--  / _ \| | | |_   _|  _  /  __ \|  \/  |  _  \
-- / /_\ \ | | | | | | | | | /  \/| .  . | | | |
-- |  _  | | | | | | | | | | |    | |\/| | | | |
-- | | | | |_| | | | \ \_/ / \__/\| |  | | |/ /
-- \_| |_/\___/  \_/  \___/ \____/\_|  |_/___/

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt_local, autocmd, user_command, fn, cmd =
  vim.opt_local, vim.api.nvim_create_autocmd, vim.api.nvim_create_user_command, vim.fn, vim.cmd

local keymap = require("utils.helpers").keymap

local lualine_picker = require("custom.lualinepicker")

-- autogroup function
local function augroup(name, opts)
  opts = opts or { clear = true }
  return vim.api.nvim_create_augroup(name, opts)
end

local au_filewrite = augroup("FileWrite")
local au_general = augroup("GeneralSettings")

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

-- ========================================================================== --
-- ==                          AUTO COMMANDS                               == --
-- ========================================================================== --

-- Start git messages in insert mode
autocmd("FileType", {
  group = au_general,
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

-- Fix comment, dont add comment on new line
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = au_general,
  pattern = { "*" },
  callback = function()
    vim.cmd([[set formatoptions-=cro]])
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = au_general,
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 400,
      on_visual = false,
    })
  end,
})

-- Close some filetypes with just <q> key
-- also disable number and cursorline
autocmd("FileType", {
  group = au_general,
  pattern = patterns,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.opt.number = false
    opt_local.cursorline = false
    keymap("n", "q", "<cmd>close<cr>")
  end,
})

-- Show cursor line only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  group = au_general,
  pattern = "*",
  command = "set cursorline",
})

autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = au_general })

-- This autocmd sets the wrap and spell options to true for filetypes
autocmd("FileType", {
  group = au_general,
  pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
  callback = function()
    opt_local.wrap = true
    opt_local.spell = true
  end,
})

-- Disable swap/undo/backup files in temp directories or shm
autocmd("BufWritePre", {
  group = au_general,
  pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
  callback = function(event)
    opt_local.undofile = false
    if event.file == "COMMIT_EDITMSG" or event.file == "MERGE_MSG" then
      opt_local.swapfile = false
    end
  end,
})

-- Disable diagnostics in node_modules (0 is current buffer only)
autocmd({ "BufRead", "BufNewFile" }, {
  group = au_general,
  pattern = "*/node_modules/*",
  command = "lua vim.diagnostic.disable(0)",
})

-- Show `` in specific files
autocmd({ "BufRead", "BufNewFile" }, {
  group = au_general,
  pattern = { "*.txt", "*.md", "*.json" },
  command = "setlocal conceallevel=0",
})

-- Disable diagnostics in a .env file
autocmd("BufRead", {
  group = au_general,
  pattern = ".env",
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

-- Reload tmux on config save
autocmd("BufWritePost", {
  group = au_filewrite,
  pattern = { "*tmux.conf" },
  command = "!tmux source <afile>;notify-send -i reload 'Reloading tmux'",
})

-- Reload zsh on save
autocmd("BufWritePost", {
  group = au_filewrite,
  pattern = { ".zshrc", ".bash_aliases", ".zshenv" },
  command = "!source .zshrc;notify-send -i reload 'Reloading zshrc'",
})

-- Reload bash on save
autocmd("BufWritePost", {
  group = au_filewrite,
  pattern = { ".bashrc", ".bash_aliases", ".bashenv" },
  command = "!source .bashrc;notify-send -i reload 'Reloading bashrc'",
})

-- Automatically close NvimTree if it's the last buffer on window
autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- Trim trailing whitespace and trailing blank lines on save
local function trim_trailing_whitespace()
  local pos = vim.api.nvim_win_get_cursor(0)
  cmd([[silent keepjumps keeppatterns %s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, pos)
end

local function trim_trailing_lines()
  local last_line = vim.api.nvim_buf_line_count(0)
  local last_nonblank_line = fn.prevnonblank(last_line)
  if last_nonblank_line < last_line then
    vim.api.nvim_buf_set_lines(0, last_nonblank_line, last_line, true, {})
  end
end

local function trim()
  if not vim.o.binary and vim.o.filetype ~= "diff" then
    trim_trailing_lines()
    trim_trailing_whitespace()
  end
end

autocmd("BufWritePre", {
  group = augroup("trim_on_save"),
  callback = trim,
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

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("lazyvim_resize_splits"),
  callback = function()
    local current_tab = fn.tabpagenr()
    cmd("tabdo wincmd =")
    cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("lazyvim_last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
  group = augroup("lazyvim_json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("lazyvim_auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    fn.mkdir(fn.fnamemodify(file, ":p:h"), "p")
  end,
})



-- auto update barbecue , more performant than using default autocmd
autocmd({
  "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",

  -- include this if you have set `show_modified` to `true`
  "BufModifiedSet",
}, {
  group = augroup("barbecue.updater"),
  callback = function()
    require("barbecue.ui").update()
  end,
})

-- ========================================================================== --
-- ==                          USER COMMANDS                               == --
-- ========================================================================== --

user_command("TrimTrailingLines", trim_trailing_lines, {})

user_command("TrimWhitespace", trim_trailing_whitespace, {})

user_command("LuaLineSelect", lualine_picker, {})
