vim.opt.shiftwidth = 4



vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("typescript"), {noremap = true})
vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").dec_normal("typescript"), {noremap = true})
