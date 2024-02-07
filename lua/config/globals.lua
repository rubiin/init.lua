-- ========================================================================== --
-- ==                          GLOBALS                                     == --
-- ========================================================================== --

local g = vim.g
local fn = vim.fn

g.vscode_snippets_path = fn.stdpath("config") .. "/misc/snippets" -- Path to vscode snippets
g.github_username = "rubiin" -- Github username
g.random_banner = true -- Random banner
g.fortune = true -- Fortune in start screen
g.markdown_recommended_style = 0 -- Fix markdown indentation settings
g.autoformat = false -- Enable LazyVim auto format
g.borderStyle = "single" ---@type "single"|"double"|"rounded"|"solid"|"none"
