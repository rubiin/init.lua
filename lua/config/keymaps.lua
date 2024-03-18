-- ========================================================================== --
-- ==                          KEYMAPS                                     == --
-- ========================================================================== --
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`

local lazyvim_util = require("lazyvim.util")
local util = require("utils")
local keymap, delete_keymap = util.keymap, util.delete_keymap
local nano = require("utils.nano-plugins")

-- Copy / Select All
keymap("n", "<C-1>", ":%y+<CR>", { desc = "Copy Whole File To Clipboard" })
keymap("n", "<C-2>", "ggVG", { desc = "Select All" })
keymap("n", "<C-3>", "ggVGx", { desc = "Delete All" })

-- Block Arrow Keys
local keygrp = util.augroup("keybind")

vim.api.nvim_create_autocmd("FileType", {
  group = keygrp,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      return
    end
    -- do the rest of the callback
    keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
    keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
    keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
    keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
  end,
})

-- Delete LazyVim default bindings which are nuisance for me
local keymaps_to_delete = {
  { "n", "<leader>l" },
  { "n", "<leader>L" },
  { "n", "<leader>-" },
  { "n", "<leader>|" },
  { "n", "<leader>fT" },
  { "n", "<leader>ft" },
}

for _, value in pairs(keymaps_to_delete) do
  delete_keymap(value)
end

-- Add LazyVim bindings for meta information
keymap("n", "<leader>;m", "<cmd>Mason<CR>", { desc = "Package Manager - [Mason]" })
keymap("n", "<leader>;p", "<cmd>Lazy<CR>", { desc = "Plugin Manager - [LazyVim]" })
keymap("n", "<leader>;e", "<cmd>LazyExtras<CR>", { desc = "Extras Manager - [LazyVim]" })
keymap("n", "<leader>;l", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })
keymap("n", "<leader>;i", "<cmd>ConformInfo<CR>", { desc = "Conform Info" })
keymap("n", "<leader>;c", lazyvim_util.news.changelog, { desc = "Changelog [LazyVim]" })
keymap("n", "<leader>;M", vim.cmd.messages, { desc = "Display Messages" })

-- keeps registers clean

keymap({ "n", "x" }, "x", '"_x')
-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap("n", "c", '"_c')
keymap("n", "C", '"_C')
keymap("n", "cc", '"_cc')
keymap("x", "c", '"_c')

-- do not clutter the register if blank line is deleted
keymap("n", "dd", function()
  if vim.api.nvim_get_current_line():find("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- Go to beginning of command in command-line mode
keymap("c", "<C-A>", "<HOME>")

-- Override LazyVim bindings for terminal
keymap("n", "<C-/>", function()
  lazyvim_util.terminal(nil, { border = vim.g.border_style })
end, { desc = "Terminal (Root Dir)" })

-- Add keymap to open URL under cursor
keymap("n", "gx", function()
  nano.open_url()
end, { desc = "Open URL Under Cursor" })

keymap("n", "z=", function()
  require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
end, { desc = "Open Telescope Spell Suggest" })

keymap("n", "<leader>yx", function()
  nano.open_at_regex_101()
end, { desc = "Open Regex At Regex101" })

keymap("n", "<leader>yy", function()
  nano.add_author_details()
end, { desc = "Add Author Details" })

keymap("n", "<leader>yz", function()
  nano.zoom()
end, { desc = "Zoom" })
