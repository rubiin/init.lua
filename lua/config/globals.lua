-- ========================================================================== --
-- ==                          GLOBALS                                     == --
-- ========================================================================== --

local g = vim.g
local fn = vim.fn

-- ========================================================================== --
-- ==                       BUILTINS                                       == --
-- ========================================================================== --

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_python_provider = 0
g.loaded_pythonx_provider = 0
g.loaded_ruby_provider = 0

-- ========================================================================== --
-- ==                       CUSTOM                                         == --
-- ========================================================================== --

g.vscode_snippets_path = fn.stdpath("config") .. "/misc/snippets" -- Path to vscode snippets
g.github_username = "rubiin" -- Github username
g.random_banner = true ---@type boolean -- Random banner
g.fortune = true ---@type boolean -- Fortune in start screen
g.border_style = "rounded" ---@type "single"|"double"|"rounded"|"solid"|"none"
g.highlighturl = true

-- ========================================================================== --
-- ==                       FUNCTIONS                                         == --
-- ========================================================================== --

local utils = require("utils")
_G.get_os = utils.get_os
_G.prequire = utils.prequire
_G.R = utils.R
_G.RELOAD = utils.RELOAD
_G.DN = utils.DN
_G.P = utils.P
