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
  pattern = constants.common_file_types,
  callback = function(event)
    vim.o.number = false
    vim.opt.spell = false
    utils.keymap("n", "q", "<cmd>close<cr>")
  end,
  desc = "Close Some Filetypes With Just <q> Key",
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
    vim.diagnostic.enable(true)
  end,
  desc = "Disable Diagnostics For .env And node_modules",
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

autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
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

-- Clear registers.
usercmd("ClearRegisters", function()
  for r in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"):gmatch("%a") do
    vim.fn.setreg(r, "")
  end
end, { desc = "Clear registers" })
