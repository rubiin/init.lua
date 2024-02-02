--                                     ██
--                                    ░░
--  ███████   █████   ██████  ██    ██ ██ ██████████
-- ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
--  ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
--  ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
--  ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
-- ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
--
--  ▓▓▓▓▓▓▓▓▓▓
-- ░▓ author ▓ rubin <@rubiin>
-- ░▓ code   ▓ https://github.com/rubiin/dotfiles
-- ░▓        ▓
-- ░▓▓▓▓▓▓▓▓▓▓
-- ░░░░░░░░░░

-- this is supposed to make loading faster
vim.loader.enable()

require("config.lazy")
require("utils.filetype")
require("config.globals") -- user and lazy globals
require("config.usercmds")
