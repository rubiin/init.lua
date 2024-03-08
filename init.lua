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
local prequire = require("utils").prequire

package.loaded["lazyvim.config.options"] = true
prequire("config.globals") -- user and lazy globals
prequire("config.lazy")
prequire("utils.filetype")
