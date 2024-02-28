vim.opt.shiftwidth = 4



local u = require("utils")

--------------------------------------------------------------------------------

-- fix my habits
u.ft_abbr("cosnt", "const")
u.ft_abbr("local", "const")
u.ft_abbr("--", "//")
u.ft_abbr("==", "===")
u.ft_abbr("~=", "!==")
u.ft_abbr("elseif", "else if")


vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("typescript"), {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").dec_normal("typescript"), {noremap = true})
