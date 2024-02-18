-- ========================================================================== --
-- ==                          GLOBALS                                     == --
-- ========================================================================== --

local g = vim.g
local fn = vim.fn

g.vscode_snippets_path = fn.stdpath("config") .. "/misc/snippets" -- Path to vscode snippets
g.github_username = "rubiin" -- Github username
g.random_banner = true ---@type boolean -- Random banner
g.fortune = true ---@type boolean -- Fortune in start screen
g.markdown_recommended_style = 0 -- Fix markdown indentation settings
g.autoformat = false ---@type boolean -- Enable LazyVim auto format
g.border_style = "rounded" ---@type "single"|"double"|"rounded"|"solid"|"none"
