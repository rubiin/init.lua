-- ========================================================================== --
-- ==                          KEYMAPS                                     == --
-- ========================================================================== --
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`
-- https://vim.fandom.com/wiki/Unused_keys check this for unused keys

-- Copy / Select All
Snacks.keymap.set("n", "<C-1>", "ggVG", { desc = "Select All" })
Snacks.keymap.set("n", "<C-2>", ":%y+<CR>", { desc = "Copy Whole File To Clipboard" })
Snacks.keymap.set("n", "<C-3>", "ggVGx", { desc = "Delete All" })

-- Block Arrow Keys
Snacks.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', { desc = "Block Left Arrow" })
Snacks.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', { desc = "Block Right Arrow" })
Snacks.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', { desc = "Block Up Arrow" })
Snacks.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', { desc = "Block Down Arrow" })

Snacks.keymap.set("v", "<leader>ct", "<cmd>lua vim.lsp.buf.format({async=true})<cr>", { desc = "Visual Formatting" })

-- -- Delete LazyVim default bindings which are nuisance for me
local keymaps_to_delete = {
  { "n", "<leader>l" },
  { "n", "<leader>L" },
  { "n", "<leader>-" },
  { "n", "<leader>|" },
  { "n", "<leader>fT" },
  { "n", "<leader>ft" },
  { "n", "<leader>cm" },

  -- harpoon bindings

  { "n", "<leader>H" },
  { "n", "<leader>h" },
}

for _, value in pairs(keymaps_to_delete) do
  Snacks.keymap.del(value[1], value[2])
end

-- Add LazyVim bindings for meta information
Snacks.keymap.set("n", "<leader>;m", "<cmd>Mason<CR>", { desc = "Package Manager - [Mason]" })
Snacks.keymap.set("n", "<leader>;p", "<cmd>Lazy<CR>", { desc = "Plugin Manager - [LazyVim]" })
Snacks.keymap.set("n", "<leader>;e", "<cmd>LazyExtras<CR>", { desc = "Extras Manager - [LazyVim]" })
Snacks.keymap.set("n", "<leader>;l", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })
Snacks.keymap.set("n", "<leader>;i", "<cmd>ConformInfo<CR>", { desc = "Conform Info" })
Snacks.keymap.set("n", "<leader>;c", LazyVim.news.changelog, { desc = "Changelog [LazyVim]" })
Snacks.keymap.set("n", "<leader>;M", vim.cmd.messages, { desc = "Display Messages" })

-- Beginning and end of line in `:` command mode
Snacks.keymap.set("c", "<C-a>", "<home>", { desc = "Beginning of Line" })
Snacks.keymap.set("c", "<C-e>", "<end>", { desc = "End of Line" })

-- Override LazyVim bindings for terminal
Snacks.keymap.set("n", "<C-/>", function()
  Snacks.terminal(nil, { border = vim.g.border_style })
end, { desc = "Terminal (Root Dir)" })

--TODO: verify these keymaps , seems to be causing issues
-- Snacks.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Esc (Terminal Mode)" })
-- Snacks.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })

-- taken from vim-unimpaired
Snacks.keymap.set("n", "[p", "O<Esc>p", { desc = "Paste Above Current Line" })
Snacks.keymap.set("n", "]p", "o<Esc>P", { desc = "Paste Below Current Line" })

-- QUITTING
Snacks.keymap.set({ "n", "x" }, "<MiddleMouse>", vim.cmd.wqall, { desc = "Quit App" })

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Additional keymaps(hacks which make using neovim more sane)

-- Make U opposite to u.
Snacks.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- keeps registers clean
Snacks.keymap.set({ "n", "x" }, "x", '"_x', { desc = "Delete Without Copying" })

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
Snacks.keymap.set("n", "c", '"_c', { desc = "Change text without yanking" }) -- Don't yank when changing text
Snacks.keymap.set("n", "C", '"_C', { desc = "Change to end of line (no yank)" }) -- Change to end of line without affecting registers
Snacks.keymap.set("n", "cc", '"_cc', { desc = "Change entire line (no yank)" }) -- Change whole line without overwriting yank buffer
Snacks.keymap.set("x", "c", '"_c', { desc = "Change selection without yanking" }) -- Visual change also ignores yank register

-- do not clutter the register if blank line is deleted
Snacks.keymap.set("n", "dd", function()
  if vim.api.nvim_get_current_line():find("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true, desc = "Delete Line Without Copying" })

-- Keeping the cursor centered.
Snacks.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Downwards" })
Snacks.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Upwards" })
Snacks.keymap.set("n", "n", "nzzzv", { desc = "Next Result" })
Snacks.keymap.set("n", "N", "Nzzzv", { desc = "Previous Result" })

-- Using H/L to go to the beginning and the end of line
-- Note: H will map to _ (the first non-whitespace character of a line)
-- It would be helpful if it is a indent line in some languages like Python, Ruby, YAML, ...
Snacks.keymap.set("n", "H", "_", { desc = "Beginning of Line" })
Snacks.keymap.set("n", "L", "$", { desc = "End of Line" })

-- Escape from insert mode with jj
Snacks.keymap.set("i", "jk", "<Esc>", { noremap = true, desc = "Escape Insert Mode" })

-- Restart Neovim.
Snacks.keymap.set('n', '<leader>R', '<cmd>restart<cr>', { desc = 'Restart Neovim' })
