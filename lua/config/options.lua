-- ========================================================================== --
-- ==                          Options                                     == --
-- ========================================================================== --

-- https://neovim.io/doc/user/quickref.html#option-list

local opt = vim.opt
local g = vim.g
local fn = vim.fn


-- Hide deprecation warnings
vim.g.deprecation_warnings = false

g.mapleader = " "
g.maplocalleader = "\\"

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- ========================================================================== --
-- ==                          LINE SETTINGS                               == --
-- ========================================================================== --

opt.relativenumber = true -- Relative line numbers
opt.number = true -- Print line number
opt.wrap = false -- Disable line wrap

-- ========================================================================== --
-- ==                              SEARCH                                  == --
-- ========================================================================== --

opt.hlsearch = true -- highlight search
opt.incsearch = true -- incremental search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.grepformat = "%f:%l:%c:%m" -- format for grep
opt.grepprg = "rg --vimgrep --no-heading --smart-case" -- use ripgrep for grep

-- ========================================================================== --
-- ==                          WINDOW SETTINGS                             == --
-- ========================================================================== --

opt.splitkeep = "screen"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.winminwidth = 5 -- Minimum window width

-- ========================================================================== --
-- ==                          CURSOR LINE                                == --
-- ========================================================================== --

opt.cursorline = true -- highlight the current cursor line

-- ========================================================================== --
-- ==                          CLIPBOARD                                   == --
-- ========================================================================== --

opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- ========================================================================== --
-- ==                          AUTO WRITE                                  == --
-- ========================================================================== --

opt.autowrite = true -- Enable auto write

-- completeopt is used to manage code suggestions
-- menuone: show popup even when there is only one suggestion
-- noinsert: Only insert text when selection is confirmed
-- noselect: force us to select one from the suggestions

opt.completeopt = "menu,menuone,noselect,noinsert"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- ========================================================================== --
-- ==                          INDENTATION                                 == --
-- ========================================================================== --

opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 4 -- Number of spaces tabs count for (when 'expandtab' is set)

-- ========================================================================== --
-- ==                          POPUP                                       == --
-- ========================================================================== --

opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- ========================================================================== --
-- ==                          TERMINAL                                    == --
-- ========================================================================== --

opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.shell = "/bin/zsh" -- Use zsh as shell

-- ========================================================================== --
-- ==                          FOLDING                                     == --
-- ========================================================================== --

opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldtext = 'v:lua.require"lazyvim.util".ui.foldtext()'
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevelstart = 99
opt.foldenable = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = '⸱',
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Scrolling settings
opt.scrolloff = 10 -- Lines of context
opt.sidescrolloff = 5 -- Columns of context

-- ========================================================================== --
-- ==                  UNDO AND SWAP                                       == --
-- ========================================================================== --

opt.undofile = true --Enable undofile
opt.undodir = fn.stdpath("config") .. "/misc/undo"
opt.swapfile = false -- Disable swapfile
opt.undolevels = 10000

opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a" -- Enable mouse mode

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Additional settings based on Neovim version
opt.smoothscroll = true

if fn.has("nvim-0.9.0") == 1 then
  opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
end

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
opt.foldtext = ""
opt.fillchars = "fold: "

vim.o.formatexpr = 'v:lua.require"lazyvim.util".format.formatexpr()'

-- ========================================================================== --
-- ==                  SPELL AND ENCODING                                  == --
-- ========================================================================== --

opt.spell = true -- Enable spell check by default
opt.encoding = "UTF-8" -- set encoding
opt.spelllang = { "en" } -- set spell check language

-- ========================================================================== --
-- ==                  PERFORMANCE SETTINGS                                == --
-- ========================================================================== --

opt.history = 1000 -- Number of command-lines that are remembered
opt.redrawtime = 100 -- Decrease redraw time
opt.updatetime = 250 -- Decrease update time
