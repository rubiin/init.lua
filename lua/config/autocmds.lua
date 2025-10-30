-- ========================================================================== --
-- ==                          AUTO COMMANDS                               == --
-- ========================================================================== --

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt, opt_local, autocmd, fn, cmd, api, bo =
  vim.opt, vim.opt_local, vim.api.nvim_create_autocmd, vim.fn, vim.cmd, vim.api, vim.bo
local usercmd = api.nvim_create_user_command

local constants = require("utils.constants")
local utils = require("utils")

local aufilewrite = utils.augroup("file_write")
local augeneral = utils.augroup("general_settings")
local aufiletype = utils.augroup("file_type")
local auterminal = utils.augroup("terminal_setting")
local fold_augroup = utils.augroup("remember_folds")

-- LAZYVIM specific autocmds---
-- These are copied from LazyVim's default autocmds but modified to fit my needs

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = utils.augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      cmd("checktime")
    end
  end,
})

autocmd("TextYankPost", {
  group = augeneral,
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

autocmd({ "VimResized" }, {
  group = utils.augroup("lazyvim_resize_splits"),
  callback = function()
    local current_tab = fn.tabpagenr()
    cmd("tabdo wincmd =")
    cmd("tabnext " .. current_tab)
  end,
  desc = "Resize Splits On VimResized",
})

autocmd("BufReadPost", {
  group = utils.augroup("lazyvim_last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = api.nvim_buf_get_mark(buf, '"')
    local line_count = api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go To Last Loc When Opening A Buffer",
})

autocmd("FileType", {
  group = aufiletype,
  pattern = constants.common_file_types,
  callback = function(event)
    vim.o.number = false
    opt.spell = false
    bo[event.buf].buflisted = false
    vim.schedule(function()
      Snacks.keymap.set("n", "q", function()
        cmd("close")
        pcall(api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
  desc = "Close Some Filetypes With Just <q> Key",
})

autocmd("FileType", {
  group = utils.augroup("lazyvim_man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    bo[event.buf].buflisted = false
  end,
  desc = "Make it easier to close man-files when opened inline",
})

autocmd("FileType", {
  group = aufiletype,
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    opt_local.wrap = true
    opt_local.spell = true
  end,
  desc = "Set Wrap And Spell For Text Files",
})

autocmd({ "FileType" }, {
  group = aufiletype,
  pattern = { "json", "jsonc", "json5", "*.txt", "*.md" },
  callback = function()
    opt_local.conceallevel = 0
  end,
  desc = "Fix Conceallevel For Specific Files",
})

autocmd({ "BufWritePre" }, {
  group = utils.augroup("lazyvim_auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    fn.mkdir(fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto Create Directory Before Writing File",
})
-----------------------------------------
--- END LAZYVIM specific autocmds -------
-----------------------------------------

autocmd({ "InsertLeave", "WinEnter" }, {
  group = augeneral,
  pattern = "*",
  command = "set cursorline",
  desc = "Set Cursorline On Active Window",
})

autocmd("FileType", {
  group = aufiletype,
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
  desc = "Start Insert Mode",
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = augeneral,
  pattern = "*",
  command = "set nocursorline",
  desc = "Set Nocursorline On Inactive Window",
})

autocmd("BufWritePost", {
  group = augeneral,
  pattern = { "*tmux.conf", "tmux.local.conf" },
  command = "execute 'silent !tmux source <afile> --silent'",
})

autocmd("BufWritePost", {
  group = augeneral,
  pattern = { "yazi.toml" },
  command = "execute 'silent !yazi --clear-cache'",
})

autocmd("BufWritePre", {
  group = augeneral,
  pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
  callback = function(event)
    opt_local.undofile = false
    if event.file == "COMMIT_EDITMSG" or event.file == "MERGE_MSG" then
      opt_local.swapfile = false
    end
  end,
  desc = "Disable swap/undo/backup Files In Temp Directories",
})

autocmd("BufRead", {
  group = augeneral,
  pattern = { ".env", "*/node_modules/*" },
  callback = function()
    vim.diagnostic.enable(true)
  end,
  desc = "Disable Diagnostics For .env And Node_modules",
})

autocmd("BufWritePre", {
  group = utils.augroup("trim_on_save"),
  callback = utils.trim,
  desc = "Trim Trailing Whitespace And Blank Lines On Save",
})

autocmd("TermOpen", {
  group = auterminal,
  pattern = "*",
  command = "startinsert | set winfixheight",
  desc = "Start Terminal In Insert Mode",
})

autocmd("TermOpen", {
  group = auterminal,
  pattern = "*",
  callback = function()
    opt_local.foldcolumn = "0"
    opt_local.signcolumn = "no"
    opt_local.number = false
  end,
  desc = "Disable Foldcolumn And Signcolumn For Terminals",
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = utils.augroup("lazyvim_checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      cmd("checktime")
    end
  end,
  desc = "Check If We Need To Reload The File When It Changed",
})

autocmd({ "BufWritePost" }, {
  pattern = "lua",
  group = augeneral,
  callback = function()
    -- if lua file and is in nvim config dir :so the file
    local current_file_path = api.nvim_buf_get_name(0)
    local is_in_config = current_file_path:find("^" .. fn.stdpath("config")) ~= nil
    if is_in_config then
      cmd.so()
    end
  end,
  desc = "Source Config Lua Files On Save",
})

autocmd("BufEnter", {
  callback = function()
    opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = utils.augroup("newline-comment"),
})

autocmd({ "BufLeave", "BufWinLeave" }, {
  group = fold_augroup,
  pattern = "*",
  callback = function()
    cmd("silent! mkview")
  end,
  desc = "Remember Folds On Buffer Exit",
})

autocmd("BufReadPost", {
  group = fold_augroup,
  pattern = "*",
  callback = function()
    cmd("silent! loadview")
  end,
  desc = "Restore Folds On Buffer Enter",
})

autocmd("InsertLeave", {
  group = augeneral,
  pattern = "*",
  command = "set nopaste",
  desc = "Turn Off Paste Mode When Leaving Insert",
})

-- Disable `snacks.indentscope` for specific filetypes :TODO
autocmd("FileType", {
  group = aufiletype,
  pattern = constants.common_file_types,
  callback = function()
    Snacks.indent.disable()
  end,
  desc = "Disable `snacks.indentscope` For Specific Filetypes",
})

local chezmoi_path = fn.resolve(fn.expand("~/.local/share/chezmoi"))
autocmd("BufWritePost", {
  pattern = {
    chezmoi_path .. "/**/*", -- files in subdirectories
  },
  callback = function()
    vim.notify("Applying chezmoi changes", vim.log.levels.INFO)
    vim.system({ "chezmoi", "update", "--exclude=encrypted" })
  end,
  desc = "Apply chezmoi changes on saving a dotfile",
})

-- ========================================================================== --
-- ==                          USER COMMANDS                               == --
-- ========================================================================== --

usercmd("TrimTrailingLines", utils.trim_trailing_lines, {
  desc = "Trim Trailing Lines",
})

usercmd("TrimWhitespace", utils.trim_trailing_whitespace, {
  desc = "Trim Trailing Whitespace",
})

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
usercmd("Cwd", function()
  cmd(":cd %:p:h")
  cmd(":pwd")
end, { desc = "Cd Current File's Directory" })

-- Write all buffers
usercmd("WriteAllBuffers", function()
  cmd("wa")
end, { desc = "Write All Changed Buffers" })

-- Clear registers.
usercmd("ClearRegisters", function()
  for r in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"):gmatch("%a") do
    fn.setreg(r, "")
  end
end, { desc = "Clear registers" })
