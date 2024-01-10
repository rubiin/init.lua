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
if vim.loader then
  vim.loader.enable()
end

require("utils.filetype")
require("config.lazy")
