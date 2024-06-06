-- ========================================================================== --
-- ==                          Options                                     == --
-- ========================================================================== --

-- https://neovim.io/doc/user/quickref.html#option-list

local opt = vim.opt
-- ========================================================================== --
-- ==                              SEARCH                                  == --
-- ========================================================================== --

opt.hlsearch = true -- highlight search
opt.incsearch = true -- incremental search
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.grepprg = "rg --vimgrep --no-heading --smart-case" -- use ripgrep for grep

-- completeopt is used to manage code suggestions
-- menuone: show popup even when there is only one suggestion
-- noinsert: Only insert text when selection is confirmed
-- noselect: force us to select one from the suggestions

opt.completeopt = "menu,menuone,noselect,noinsert"

-- ========================================================================== --
-- ==                          INDENTATION                                 == --
-- ========================================================================== --

opt.softtabstop = 4 -- Number of spaces tabs count for (when 'expandtab' is set)

-- ========================================================================== --
-- ==                          TERMINAL                                    == --
-- ========================================================================== --

opt.shell = "/bin/zsh" -- Use zsh as shell

-- ========================================================================== --
-- ==                          FOLDING                                     == --
-- ========================================================================== --

opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevelstart = 99
opt.foldenable = true

-- Scrolling settings
opt.scrolloff = 10 -- Lines of context
opt.sidescrolloff = 5 -- Columns of context

-- ========================================================================== --
-- ==                  UNDO AND SWAP                                       == --
-- ========================================================================== --

opt.undodir = vim.fn.stdpath("config") .. "/misc/undo"
opt.swapfile = false -- Disable swapfile

opt.fillchars = "fold: "

-- ========================================================================== --
-- ==                  SPELL AND ENCODING                                  == --
-- ========================================================================== --

opt.spell = true -- Enable spell check by default
opt.encoding = "UTF-8" -- set encoding

-- ========================================================================== --
-- ==                  PERFORMANCE SETTINGS                                == --
-- ========================================================================== --

opt.history = 1000 -- Number of command-lines that are remembered
