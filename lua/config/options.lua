--  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.
--  | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
--  | |     ____     | || |   ______     | || |  _________   | || |     _____    | || |     ____     | || | ____  _____  | || |    _______   | |
--  | |   .'    `.   | || |  |_   __ \   | || | |  _   _  |  | || |    |_   _|   | || |   .'    `.   | || ||_   \|_   _| | || |   /  ___  |  | |
--  | |  /  .--.  \  | || |    | |__) |  | || | |_/ | | \_|  | || |      | |     | || |  /  .--.  \  | || |  |   \ | |   | || |  |  (__ \_|  | |
--  | |  | |    | |  | || |    |  ___/   | || |     | |      | || |      | |     | || |  | |    | |  | || |  | |\ \| |   | || |   '.___`-.   | |
--  | |  \  `--'  /  | || |   _| |_      | || |    _| |_     | || |     _| |_    | || |  \  `--'  /  | || | _| |_\   |_  | || |  |`\____) |  | |
--  | |   `.____.'   | || |  |_____|     | || |   |_____|    | || |    |_____|   | || |   `.____.'   | || ||_____|\____| | || |  |_______.'  | |
--  | |              | || |              | || |              | || |              | || |              | || |              | || |              | |
--  | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
--   '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local o = vim.opt
local g = vim.g

g.editorconfig = false

-- Enable undofile
o.undodir = vim.fn.expand("~/.config/nvim/undo")
o.undofile = true
-- Disable swapfile
o.swapfile = false

-- Decrease update time
o.updatetime = 50

-- Enable spell check by default unless in vscode
if not vim.g.vscode then
  o.spell = true
end

-- code folding
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

o.encoding = "UTF-8" -- set encoding
