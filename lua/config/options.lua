-- ========================================================================== --
-- ==                          Options                                     == --
-- ========================================================================== --

-- https://neovim.io/doc/user/quickref.html#option-list

local o = vim.opt
local g = vim.g
local fn = vim.fn

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

o.relativenumber = true -- Relative line numbers
o.number = true -- Print line number
o.wrap = false -- Disable line wrap

-- ========================================================================== --
-- ==                              SEARCH                                  == --
-- ========================================================================== --

o.hlsearch = true -- highlight search
o.incsearch = true -- incremental search
o.ignorecase = true -- ignore case when searching
o.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
o.grepformat = "%f:%l:%c:%m" -- format for grep
o.grepprg = "rg --vimgrep --no-heading --smart-case" -- use ripgrep for grep

-- ========================================================================== --
-- ==                          WINDOW SETTINGS                             == --
-- ========================================================================== --

o.splitkeep = "screen"
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.winminwidth = 5 -- Minimum window width

-- ========================================================================== --
-- ==                          CUSRSOR LINE                                == --
-- ========================================================================== --

o.cursorline = true -- highlight the current cursor line

-- ========================================================================== --
-- ==                          CLIPBOARD                                   == --
-- ========================================================================== --

o.clipboard = "unnamedplus" -- Sync with system clipboard

-- ========================================================================== --
-- ==                          AUTO WRITE                                  == --
-- ========================================================================== --

o.autowrite = true -- Enable auto write

-- completeopt is used to manage code suggestions
-- menuone: show popup even when there is only one suggestion
-- noinsert: Only insert text when selection is confirmed
-- noselect: force us to select one from the suggestions

o.completeopt = "menu,menuone,noselect,noinsert"
o.conceallevel = 3 -- Hide * markup for bold and italic
o.confirm = true -- Confirm to save changes before exiting modified buffer

-- ========================================================================== --
-- ==                          INDENTATION                                 == --
-- ========================================================================== --

o.expandtab = true -- Use spaces instead of tabs
o.shiftround = true -- Round indent
o.shiftwidth = 2 -- Size of an indent
o.smartindent = true -- Insert indents automatically
o.softtabstop = 4 -- Number of spaces tabs count for (when 'expandtab' is set)

-- ========================================================================== --
-- ==                          POPUP                                       == --
-- ========================================================================== --

o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup

-- ========================================================================== --
-- ==                          TERMINAL                                    == --
-- ========================================================================== --

o.termguicolors = true -- True color support
o.timeoutlen = 300
o.shell = "/bin/zsh" -- Use zsh as shell

-- ========================================================================== --
-- ==                          FOLDING                                     == --
-- ========================================================================== --

o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldtext = 'v:lua.require"lazyvim.util".ui.foldtext()'
o.foldcolumn = "1" -- '0' is not bad
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = '⸱',
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Scrolling settings
o.scrolloff = 10 -- Lines of context
o.sidescrolloff = 5 -- Columns of context

-- ========================================================================== --
-- ==                  UNDO AND SWAP                                       == --
-- ========================================================================== --

o.undofile = true --Enable undofile
o.undodir = fn.stdpath("config") .. "/misc/undo"
o.swapfile = false -- Disable swapfile
o.undolevels = 10000

o.inccommand = "nosplit" -- preview incremental substitute
o.laststatus = 3 -- global statusline
o.list = true -- Show some invisible characters (tabs...
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
o.mouse = "a" -- Enable mouse mode

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.showmode = false -- Dont show mode since we have a statusline
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
o.wildmode = "longest:full,full" -- Command-line completion mode

-- Additional settings based on Neovim version
if fn.has("nvim-0.10") == 1 then
  o.smoothscroll = true
end

if fn.has("nvim-0.9.0") == 1 then
  o.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if fn.has("nvim-0.10") == 1 then
  o.foldmethod = "expr"
  o.foldexpr = 'v:lua.require"lazyvim.util".ui.foldexpr()'
else
  o.foldmethod = "indent"
end

o.formatexpr = 'v:lua.require"lazyvim.util".format.formatexpr()'

-- ========================================================================== --
-- ==                  SPELL AND ENCODING                                  == --
-- ========================================================================== --

o.spell = true -- Enable spell check by default
o.encoding = "UTF-8" -- set encoding
o.fileencoding = "UTF-8" -- set encoding
o.spelllang = "en" -- set spell check language

-- ========================================================================== --
-- ==                  PERFORMANCE SETTINGS                                == --
-- ========================================================================== --

o.history = 1000 -- Number of command-lines that are remembered
o.redrawtime = 100 -- Decrease redraw time
o.updatetime = 250 -- Decrease update time

-- ========================================================================== --
-- ==                  PROVIDER                                            == --
-- ========================================================================== --

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_python_provider = 0
g.loaded_pythonx_provider = 0
g.loaded_ruby_provider = 0

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
