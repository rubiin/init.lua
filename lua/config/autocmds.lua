-- ========================================================================== --
-- ==                          AUTO COMMANDS                               == --
-- ========================================================================== --

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local opt_local, autocmd, fn, cmd, api = vim.opt_local, vim.api.nvim_create_autocmd, vim.fn, vim.cmd, vim.api
local usercmd = api.nvim_create_user_command

local constants = require("utils.constants")
local utils = require("utils")

local aufilewrite = utils.augroup("file_write")
local augeneral = utils.augroup("general_settings")
local aufiletype = utils.augroup("file_type")
local auterminal = utils.augroup("terminal_setting")
local fold_augroup = utils.augroup("remember_folds")

autocmd("FileType", {
  group = aufiletype,
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
  desc = "Start Insert Mode",
})

autocmd("TextYankPost", {
  group = augeneral,
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 400,
    })
  end,
  desc = "Highlight On Yank",
})

autocmd("FileType", {
  group = aufiletype,
  pattern = constants.exclude_file_types,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.o.number = false
    opt_local.cursorline = false
    vim.opt.spell = false
    utils.keymap("n", "q", "<cmd>close<cr>")
  end,
  desc = "Close Some Filetypes With Just <q> Key",
})

autocmd({ "InsertLeave", "WinEnter" }, {
  group = augeneral,
  pattern = "*",
  command = "set cursorline",
  desc = "Set Cursorline On Active Window",
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = augeneral,
  pattern = "*",
  command = "set nocursorline",
  desc = "Set Nocursorline On Inactive Window",
})

autocmd("FileType", {
  group = aufiletype,
  pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
  callback = function()
    opt_local.wrap = true
    opt_local.spell = true
  end,
  desc = "Set Wrap And Spell For Text Files",
})

-- Use the more sane snippet session leave logic. Copied from:
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
autocmd("ModeChanged", {
  group = utils.augroup("luasnip_unlink"),
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

autocmd("BufWritePost", {
  group = augeneral,
  pattern = { "*tmux.conf", "tmux.local.conf" },
  command = "execute 'silent !tmux source <afile> --silent'",
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
    vim.diagnostic.disable(0)
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
  desc = "Go To Last Loc When Opening A Buffer",
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

autocmd({ "BufWritePost" }, {
  pattern = "lua",
  group = augeneral,
  callback = function()
    -- if lua file and is in nvim config dir :so the file
    local current_file_path = vim.api.nvim_buf_get_name(0)
    local is_in_config = current_file_path:find("^" .. vim.fn.stdpath("config")) ~= nil
    if is_in_config then
      cmd.so()
    end
  end,
  desc = "Source Config Lua Files On Save",
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

autocmd("FileType", {
  group = aufiletype,
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

autocmd("InsertLeave", {
  group = augeneral,
  pattern = "*",
  command = "set nopaste",
  desc = "Turn Off Paste Mode When Leaving Insert",
})

autocmd("BufEnter", {
  group = augeneral,
  pattern = "*",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
  desc = "Disable Auto Comment",
})

-- Disable `mini.indentscope` for specific filetypes
autocmd("FileType", {
  group = aufiletype,
  pattern = constants.common_file_types,
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
  desc = "Disable `mini.indentscope` For Specific Filetypes",
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

usercmd("NerdFontPicker", function()
  require("telescope").extensions.nerdfont.nerdfont()
end, {
  desc = "Select Nerd Fonts",
})

usercmd("LuaLinePicker", function()
  require("telescope").extensions.lualine.lualine()
end, {
  desc = "Select LuaLine Styles",
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
