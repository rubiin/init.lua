-- ========================================================================== --
-- ==                          KEYMAPS                                     == --
-- ========================================================================== --
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`
-- https://vim.fandom.com/wiki/Unused_keys check this for unused keys

local util = require("utils")
local keymap, delete_keymap = util.keymap, util.delete_keymap

-- Copy / Select All
keymap("n", "<C-1>", "ggVG", { desc = "Select All" })
keymap("n", "<C-2>", ":%y+<CR>", { desc = "Copy Whole File To Clipboard" })
keymap("n", "<C-3>", "ggVGx", { desc = "Delete All" })

-- Block Arrow Keys
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

keymap("v", "<leader>ct", "<cmd>lua vim.lsp.buf.format({async=true})<cr>", { desc = "Visual Formatting" })

-- Delete LazyVim default bindings which are nuisance for me
local keymaps_to_delete = {
  { "n", "<leader>l" },
  { "n", "<leader>L" },
  { "n", "<leader>-" },
  { "n", "<leader>|" },
  { "n", "<leader>fT" },
  { "n", "<leader>ft" },
  { "n", "<leader>cm" },
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
keymap("n", "<leader>;c", LazyVim.news.changelog, { desc = "Changelog [LazyVim]" })
keymap("n", "<leader>;M", vim.cmd.messages, { desc = "Display Messages" })

-- Beginning and end of line in `:` command mode
keymap("c", "<C-a>", "<home>")
keymap("c", "<C-e>", "<end>")

-- Override LazyVim bindings for terminal
keymap("n", "<C-/>", function()
  Snacks.terminal(nil, { border = vim.g.border_style })
end, { desc = "Terminal (Root Dir)" })

--TODO: verify these keymaps , seems to be causing issues
-- keymap("t", "<Esc>", [[<C-\><C-n>]], { desc = "Esc (Terminal Mode)" })
-- keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })

-- taken from vim-unimpaired
keymap("n", "[p", "O<Esc>p") -- paste above current line
keymap("n", "]p", "o<Esc>P") -- paste below current line

-- QUITTING
keymap({ "n", "x" }, "<MiddleMouse>", vim.cmd.wqall, { desc = "Quit App" })

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Additional keymaps(hacks which make using neovim more sane)

-- Make U opposite to u.
keymap("n", "U", "<C-r>", { desc = "Redo" })

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

-- Keeping the cursor centered.
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll Downwards" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll Upwards" })
keymap("n", "n", "nzzzv", { desc = "Next Result" })
keymap("n", "N", "Nzzzv", { desc = "Previous Result" })

-- Using H/L to go to the beginning and the end of line
-- Note: H will map to _ (the first non-whitespace character of a line)
-- It would be helpful if it is a indent line in some languages like Python, Ruby, YAML, ...
keymap("n", "H", "_")
keymap("n", "L", "$")

-- Escape from insert mode with jj
keymap("i", "jj", "<Esc>", { noremap = false })
