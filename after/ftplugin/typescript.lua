vim.opt.shiftwidth = 4

local utils = require("utils")

--------------------------------------------------------------------------------

-- fix my habits
utils.ft_abbr("cosnt", "const")
utils.ft_abbr("local", "const")
utils.ft_abbr("--", "//")
utils.ft_abbr("==", "===")
utils.ft_abbr("~=", "!==")
utils.ft_abbr("elseif", "else if")

vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("typescript"), { noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").dec_normal("typescript"), { noremap = true })
