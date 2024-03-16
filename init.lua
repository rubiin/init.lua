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

package.loaded["lazyvim.config.options"] = true
require("config.globals") -- user and lazy globals
require("config.lazy")
require("filetype")
require("spellfixes")
