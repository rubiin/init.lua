-- __________ _____ _____ _____ _   _  _____
-- |  _  | ___ \_   _|_   _|  _  | \ | |/  ___|
-- | | | | |_/ / | |   | | | | | |  \| |\ `--.
-- | | | |  __/  | |   | | | | | | . ` | `--. \
-- \ \_/ / |     | |  _| |_\ \_/ / |\  |/\__/ /
--  \___/\_|     \_/  \___/ \___/\_| \_/\____/

-- https://neovim.io/doc/user/quickref.html#option-list

local o = vim.opt
local g = vim.g
local fn = vim.fn

g.mapleader = ' '
g.maplocalleader = '\\'

-- Enable LazyVim auto format
g.autoformat = false

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
g.root_spec = { 'lsp', { '.git', 'lua' }, 'cwd' }

-- line numbers
o.relativenumber = true -- Relative line numbers
o.number = true -- Print line number

-- line wrapping
o.wrap = false -- Disable line wrap

-- search settings
o.hlsearch = true -- highlight search
o.incsearch = true -- incremental search
o.ignorecase = true -- ignore case when searching
o.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- tab settings
o.splitkeep = 'screen'
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current

-- cursor line
o.cursorline = true -- highlight the current cursor line

-- clipboard
o.clipboard = 'unnamedplus' -- Sync with system clipboard

o.autowrite = true -- Enable auto write
o.completeopt = 'menu,menuone,noselect'
o.conceallevel = 3 -- Hide * markup for bold and italic
o.confirm = true -- Confirm to save changes before exiting modified buffer

o.expandtab = true -- Use spaces instead of tabs
o.formatoptions = 'jcroqlnt' -- tcqj
o.grepformat = '%f:%l:%c:%m'
o.grepprg = 'rg --vimgrep'

o.inccommand = 'nosplit' -- preview incremental substitute
o.laststatus = 3 -- global statusline
o.list = true -- Show some invisible characters (tabs...
o.mouse = 'a' -- Enable mouse mode

o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.scrolloff = 4 -- Lines of context
o.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
o.shiftround = true -- Round indent
o.shiftwidth = 2 -- Size of an indent
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.showmode = false -- Dont show mode since we have a statusline
o.sidescrolloff = 8 -- Columns of context
o.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time

o.smartindent = true -- Insert indents automatically


o.softtabstop = 4
o.termguicolors = true -- True color support
o.timeoutlen = 300
o.undolevels = 10000
o.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
o.wildmode = 'longest:full,full' -- Command-line completion mode
o.winminwidth = 5 -- Minimum window width

o.shell = '/bin/zsh' -- Use zsh as shell

if fn.has('nvim-0.10') == 1 then o.smoothscroll = true end

-- Folding
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
o.foldcolumn = '1' -- '0' is not bad
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = {
  foldopen = '',
  foldclose = '',
  -- fold = "⸱",
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}


if fn.has('nvim-0.9.0') == 1 then o.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]] end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if fn.has('nvim-0.10') == 1 then
  o.foldmethod = 'expr'
  o.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
else
  o.foldmethod = 'indent'
end

vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"

-- Fix markdown indentation settings
g.markdown_recommended_style = 0

g.editorconfig = false

-- Undo and swap settings
o.undofile = true --Enable undofile
o.undodir = fn.expand('~/.config/nvim/misc/undo')
o.swapfile = false -- Disable swapfile

-- Decrease update time
o.updatetime = 50

-- Enable spell check by default unless in vscode
if not g.vscode then o.spell = true end

o.encoding = 'UTF-8' -- set encoding
o.spelllang = { 'en' } -- set spell check language

-- Number of command-lines that are remembered
o.history = 10000

-- Decrease redraw time
o.redrawtime = 100

