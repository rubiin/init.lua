-- ========================================================================== --
-- ==                          KEYMAPS                                     == --
-- ========================================================================== --
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`

local lazyvim_util = require("lazyvim.util")
local keymap = require("utils").keymap
local nano = require("utils.nano-plugins")

-- Copy all text in buffer to clipboard with Ctrl-1
keymap("n", "<C-1>", ":%y+<CR>", { desc = "Copy Whole File To Clipboard" })

-- Select all text in buffer with Ctrl-2
keymap("n", "<C-2>", "ggVG", { desc = "Select All" })

-- Add LazyVim bindings for meta information
keymap("n", "<leader>;m", "<cmd>Mason<CR>", { desc = "Package Manager - [Mason]" })
keymap("n", "<leader>;p", "<cmd>Lazy<CR>", { desc = "Plugin Manager - [LazyVim]" })
keymap("n", "<leader>;e", "<cmd>LazyExtras<CR>", { desc = "Extras Manager - [LazyVim]" })
keymap("n", "<leader>;l", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })
keymap("n", "<leader>;i", "<cmd>ConformInfo<CR>", { desc = "Conform Info" })
keymap("n", "<leader>;c", lazyvim_util.news.changelog, { desc = "Changelog [LazyVim]" })
keymap("n", "<leader>;M", vim.cmd.messages, { desc = "Display Messages" })

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

-- keeps registers clean
keymap({ "n", "x" }, "x", '"_x')
keymap({ "n", "x" }, "c", '"_c')
keymap("n", "C", '"_C')

-- do not clutter the register if blank line is deleted
keymap("n", "dd", function()
  if vim.api.nvim_get_current_line():find("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true })
