--   ___  _   _ _____ _____ _____ ___  ________
--  / _ \| | | |_   _|  _  /  __ \|  \/  |  _  \
-- / /_\ \ | | | | | | | | | /  \/| .  . | | | |
-- |  _  | | | | | | | | | | |    | |\/| | | | |
-- | | | | |_| | | | \ \_/ / \__/\| |  | | |/ /
-- \_| |_/\___/  \_/  \___/ \____/\_|  |_/___/

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt_local, autocmd, command, fn, cmd =
  vim.opt_local, vim.api.nvim_create_autocmd, vim.api.nvim_create_user_command, vim.fn, vim.cmd

local keymap = require('utils.helpers').map

-- autogroup function
local function augroup(name, opts)
  opts = opts or { clear = true }
  return vim.api.nvim_create_augroup(name, opts)
end


local au_filetypes = augroup("ConfigFileType")

local patterns = {
  'dap-float',
  'fugitive',
  'fugitiveblame',
  'git',
  'help',
  'lspinfo',
  'man',
  'notify',
  'null-ls-info',
  'none-ls-info',
  'PlenaryTestPopup',
  'qf',
  'query', -- :InspectTree
  'spectre_panel',
  'startuptime',
  'tsplayground',
}


local au_filewrite = augroup("ConfigFileWrite")
-- reload tmux on config save
autocmd('BufWritePost', {
  group = au_filewrite,
  pattern = { '*tmux.conf' },
  command = "!tmux source <afile>;notify-send -i reload 'Reloading tmux",
})

-- reload zsh on save
autocmd('BufWritePost', {
  group = au_filewrite,
  pattern = { '.zshrc', '*aliases' },
  command = "!source .zshrc;notify-send -i reload 'Reloading zshrc'",
})

-- Automatically close NvimTree if it's the last buffer on window
autocmd('QuitPre', {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match('NvimTree_') ~= nil then table.insert(invalid_win, w) end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('HighlightYank'),
  callback = function()
    vim.highlight.on_yank({
      higroup = 'Visual',
      timeout = 400,
      on_visual = false,
    })
  end,
})

-- close some filetypes with just <q> key
autocmd('FileType', {
  group = au_filetypes,
  pattern = patterns,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    keymap('n', 'q', '<cmd>close<cr>')
  end,
})

-- show cursor line only in active window
autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = augroup('CursorLine'),
})
autocmd({ 'InsertEnter', 'WinLeave' }, { pattern = '*', command = 'set nocursorline', group = augroup('CursorLine') })

-- set mdx file to markdown
autocmd('BufEnter', {
  pattern = { '*.mdx' },
  group = augroup('md_mdx'),
  callback = function() cmd('setfiletype markdown') end,
})

-- This autocmd sets the wrap and spell options to true for filetypes ".txt", ".md", ".tex", and ".typ".
autocmd('FileType', {
  group = au_filetypes,
  pattern = { '*.txt', '*.md', '*.tex', '*.typ' },
  callback = function()
    opt_local.wrap = true
    opt_local.spell = true
  end,
})

-- Disable swap/undo/backup files in temp directories or shm
autocmd('BufWritePre', {
  group = augroup('undo_disable'),
  pattern = { '/tmp/*', '*.tmp', '*.bak', 'COMMIT_EDITMSG', 'MERGE_MSG' },
  callback = function(event)
    opt_local.undofile = false
    if event.file == 'COMMIT_EDITMSG' or event.file == 'MERGE_MSG' then opt_local.swapfile = false end
  end,
})

-- Trim trailing whitespace and trailing blank lines on save
local function trim_trailing_whitespace()
  local pos = vim.api.nvim_win_get_cursor(0)
  cmd([[silent keepjumps keeppatterns %s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, pos)
end
command('TrimWhitespace', trim_trailing_whitespace, {})

local function trim_trailing_lines()
  local last_line = vim.api.nvim_buf_line_count(0)
  local last_nonblank_line = fn.prevnonblank(last_line)
  if last_nonblank_line < last_line then vim.api.nvim_buf_set_lines(0, last_nonblank_line, last_line, true, {}) end
end
command('TrimTrailingLines', trim_trailing_lines, {})

local function trim()
  if not vim.o.binary and vim.o.filetype ~= 'diff' then
    trim_trailing_lines()
    trim_trailing_whitespace()
  end
end
autocmd('BufWritePre', {
  group = augroup('trim_on_save'),
  callback = trim,
})

-- Disable diagnostics in node_modules (0 is current buffer only)
autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*/node_modules/*',
  command = 'lua vim.diagnostic.disable(0)',
})

-- Show `` in specific files
autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.txt', '*.md', '*.json' },
  command = 'setlocal conceallevel=0',
})

-- Disable diagnostics in a .env file
autocmd('BufRead', {
  pattern = '.env',
  callback = function() vim.diagnostic.disable(0) end,
})

-- start terminal in insert mode
autocmd('TermOpen', {
  group = augroup('bufcheck'),
  pattern = '*',
  command = 'startinsert | set winfixheight',
})

-- start git messages in insert mode
autocmd('FileType', {
  group = au_filetypes,
  pattern = { 'gitcommit', 'gitrebase' },
  command = 'startinsert | 1',
})
