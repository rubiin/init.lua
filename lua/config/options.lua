-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local g = vim.g

g.editorconfig = false

-- Enable undofile
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Disable swapfile
opt.swapfile = false

-- Decrease update time
opt.updatetime = 50

-- Enable spell check by default unless in vscode
if not vim.g.vscode then
  opt.spell = true
end

-- code folding
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
