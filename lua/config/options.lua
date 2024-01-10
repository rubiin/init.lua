-- ___________ _____ _____ _____ _   _  _____
-- |  _  | ___ \_   _|_   _|  _  | \ | |/  ___|
-- | | | | |_/ / | |   | | | | | |  \| |\ `--.
-- | | | |  __/  | |   | | | | | | . ` | `--. \
-- \ \_/ / |     | |  _| |_\ \_/ / |\  |/\__/ /
--  \___/\_|     \_/  \___/ \___/\_| \_/\____/

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
if not g.vscode then
  o.spell = true
end

-- code folding
o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

o.encoding = "UTF-8" -- set encoding

-- Number of command-lines that are remembered
o.history = 10000

-- Decrease redraw time
o.redrawtime = 100
