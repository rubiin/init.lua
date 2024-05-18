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

-- lazy-load spellfixes
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    require("spellfixes")
  end,
})
