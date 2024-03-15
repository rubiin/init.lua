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

g.skip_ts_context_commentstring_module = true -- Skip ts_context_commentstring module to speed up loading
g.vscode_snippets_path = fn.stdpath("config") .. "/misc/snippets" -- Path to vscode snippets
g.github_username = "rubiin" -- Github username
g.random_banner = true ---@type boolean -- Random banner
g.fortune = true ---@type boolean -- Fortune in start screen
g.markdown_recommended_style = 0 -- Fix markdown indentation settings
g.autoformat = false ---@type boolean -- Enable LazyVim auto format
g.border_style = "rounded" ---@type "single"|"double"|"rounded"|"solid"|"none"
