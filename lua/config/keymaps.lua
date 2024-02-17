-- ========================================================================== --
-- ==                          Key Maps                                    == --
-- ========================================================================== --
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Not everything needs to be a keymap, you can also use `user_commands`

local lazyvim_util = require("lazyvim.util")
local utils = require("utils")

utils.cowboy()

-- Add toggle gitsigns blame line
if lazyvim_util.has("gitsigns.nvim") then
  utils.keymap("n", "<leader>uB", function()
    require("gitsigns").toggle_current_line_blame()
  end, {
    desc = "Toggle Current Line Blame",
  })
end

-- Delete LazyVim default bindings which are nuisance for me
-- local keymaps_to_delete = {
--   { "n", "<leader>l" },
--   { "n", "<leader>L" },
--   { "n", "<leader>-" },
--   { "n", "<leader>|" },
--   { "n", "<leader>fT" },
--   { "n", "<leader>ft" },
-- }
-- utils.delete_keymaps(keymaps_to_delete)

-- Copy whole file content to clipboard with C-1
utils.keymap("n", "<C-1>", ":%y+<CR>", { desc = "Copy Whole File To Clipboard" })

-- Select all text in buffer with C-2
utils.keymap("n", "<C-2>", "ggVG", { desc = "Select All" })

-- Add LazyVim bindings for meta information
utils.keymap("n", "<leader>;m", "<cmd>Mason<CR>", { desc = "Package Manager - [Mason]" })
utils.keymap("n", "<leader>;p", "<cmd>Lazy<CR>", { desc = "Plugin Manager - [LazyVim]" })
utils.keymap("n", "<leader>;e", "<cmd>LazyExtras<CR>", { desc = "Extras Manager - [LazyVim]" })
utils.keymap("n", "<leader>;l", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })
utils.keymap("n", "<leader>;i", "<cmd>ConformInfo<CR>", { desc = "Conform Info" })
utils.keymap("n", "<leader>;c", lazyvim_util.news.changelog, { desc = "Changelog [LazyVim]" })
utils.keymap("n", "<leader>;M", vim.cmd.messages, { desc = "Display Messages" })

-- Add spell check to cspell
utils.keymap("n", "<leader>cs", function()
  require("utils.cspell").add_word_to_c_spell_dictionary()
end, { desc = "Add Word To Cspell Dictionary" })

-- Override LazyVim bindings for terminal
utils.keymap("n", "<C-/>", function()
  lazyvim_util.terminal(nil, { border = "rounded" })
end, { desc = "Terminal (Root Dir)" })

-- Search for 'FIXME', 'HACK', 'TODO', 'NOTE'
utils.keymap("n", "<leader>ct", function()
  utils.search_todos()
end, { desc = "List Todos On QuickFix" })

-- Add keymap to open URL under cursor
utils.keymap("n", "gx", function()
  utils.open_url()
end, { desc = "Open URL Under Cursor" })

local M = {}

M.neogen = {
  {
    "<leader>cc",
    function()
      require("neogen").generate({})
    end,
    desc = "Neogen Documentation",
  },
}

M.lspsaga = {
  { "<leader>cp", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
  { "<leader>ca", "<Cmd>Lspsaga code_action<CR>", desc = "Code Action" },
  {
    "<leader>cA",
    function()
      require("lspsaga.codeaction").code_action({ context = { only = "source" } })
    end,
    desc = "Code Action (Source)",
  },

  { "<leader>uo", "<Cmd>Lspsaga outline<CR>", desc = "Outline Toggle" },
  { "K", "<Cmd>Lspsaga hover_doc ++silent<CR>", desc = "Hover Doc" },
}

M.hardtime = {
  {
    "<leader>uh",
    "<cmd>Hardtime toggle<CR>",
    desc = "Toggle Hardtime",
  },
  {
    "<leader>hr",
    "<cmd>Hardtime report<CR>",
    desc = "Hardtime Report",
  },
}

M.autosave = {
  {
    "<Leader>ua",
    "<cmd>ASToggle<CR>",
    desc = "Toggle Auto Save",
  },
}

M.dail = {
  {
    "<C-a>",
    function()
      return require("dial.map").inc_normal("custom")
    end,
    expr = true,
    desc = "Increment",
  },
  {
    "<C-x>",
    function()
      return require("dial.map").dec_normal("custom")
    end,
    expr = true,
    desc = "Decrement",
  },
  {
    "<C-a>",
    function()
      return require("dial.map").inc_normal("visual")
    end,
    mode = "v",
    expr = true,
    desc = "Increment",
  },
  {
    "<C-x>",
    function()
      return require("dial.map").dec_normal("visual")
    end,
    mode = "v",
    expr = true,
    desc = "Decrement",
  },
}

M.ufo = {
  {
    "zR",
    function()
      require("ufo").openAllFolds()
    end,
    desc = "Open All Folds",
  },
  {
    "zM",
    function()
      require("ufo").closeAllFolds()
    end,
    desc = "Close All Folds",
  },
  {
    "zp",
    function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end,
    desc = "Peek Fold",
  },
}

local cwd = vim.loop.cwd()

M.toggleterm = {
  {
    "<leader>Tf",
    function()
      local count = vim.v.count1
      require("toggleterm").toggle(count, 0, cwd, "float")
    end,
    desc = "ToggleTerm (float cwd)",
  },
  {
    "<leader>Th",
    function()
      local count = vim.v.count1
      require("toggleterm").toggle(count, 15, cwd, "horizontal")
    end,
    desc = "ToggleTerm (horizontal cwd)",
  },
  {
    "<leader>Tv",
    function()
      local count = vim.v.count1
      require("toggleterm").toggle(count, vim.o.columns * 0.4, cwd, "vertical")
    end,
    desc = "ToggleTerm (vertical cwd)",
  },
  {
    "<leader>Ts",
    "<cmd>TermSelect<cr>",
    desc = "Select term",
  },
  {
    "<leader>Tt",
    function()
      require("toggleterm").toggle(1, 100, cwd, "tab")
    end,
    desc = "ToggleTerm (tab cwd)",
  },
}

M.refactoring = {
  {
    "<leader>rs",
    function()
      require("telescope").extensions.refactoring.refactors()
    end,
    mode = "v",
    desc = "Refactor",
  },
  {
    "<leader>ri",
    function()
      require("refactoring").refactor("Inline Variable")
    end,
    mode = { "n", "v" },
    desc = "Inline Variable",
  },
  {
    "<leader>rb",
    function()
      require("refactoring").refactor("Extract Block")
    end,
    desc = "Extract Block",
  },
  {
    "<leader>rf",
    function()
      require("refactoring").refactor("Extract Block To File")
    end,
    desc = "Extract Block To File",
  },
  {
    "<leader>rP",
    function()
      require("refactoring").debug.printf({ below = false })
    end,
    desc = "Debug Print",
  },
  {
    "<leader>rp",
    function()
      require("refactoring").debug.print_var({ normal = true })
    end,
    desc = "Debug Print Variable",
  },
  {
    "<leader>rc",
    function()
      require("refactoring").debug.cleanup({})
    end,
    desc = "Debug Cleanup",
  },
  {
    "<leader>rf",
    function()
      require("refactoring").refactor("Extract Function")
    end,
    mode = "v",
    desc = "Extract Function",
  },
  {
    "<leader>rF",
    function()
      require("refactoring").refactor("Extract Function To File")
    end,
    mode = "v",
    desc = "Extract Function To File",
  },
  {
    "<leader>rx",
    function()
      require("refactoring").refactor("Extract Variable")
    end,
    mode = "v",
    desc = "Extract Variable",
  },
  {
    "<leader>rp",
    function()
      require("refactoring").debug.print_var()
    end,
    mode = "v",
    desc = "Debug Print Variable",
  },
}

M.cellular_automaton = {
  { "<leader>yc", "<cmd>CellularAutomaton game_of_life<cr>", { desc = "Game Of Life" } },
  { "<leader>yd", "<cmd>CellularAutomaton make_it_rain<cr>", { desc = "Make It Rain Baby" } },
}

M.zen_mode = {
  { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
}

M.zoom = {
  {
    "<leader>uz",
    function()
      require("mini.misc").zoom()
    end,
    desc = "Toggle Zoom",
  },
}

M.tmux = {
  { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
}

M.spectre = {
  {
    "<leader>sr",
    function()
      require("spectre").open()
    end,
    desc = "Replace In Files",
  },
  {
    "<leader>sf",
    function()
      require("spectre").open_file_search()
    end,
    desc = "Replace In Current File",
  },

  {
    "<leader>sp",
    function()
      require("spectre").open(get_spectre_options())
    end,
    desc = "Replace In Files (Root dir)",
  },
  -- Search current word
  {
    "<leader>sP",
    function()
      require("spectre").open_visual(get_spectre_options({ select_word = true }))
    end,
    desc = "Replace Current Word (Root dir)",
  },
  -- Open search with select word in visual mode
  {
    "<leader>sr",
    function()
      require("spectre").open_visual(get_spectre_options())
    end,
    mode = "v",
    silent = true,
    desc = "Replace Current Word (Root dir)",
  },
}

M.colorscheme = {
  { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
}

M.telescope = {
  {
    "<leader>sB",
    "<cmd>Telescope find_files cwd=%:p:h<cr>",
    desc = "Browse Files (cwd)",
  },
  {
    "<leader>cu",
    "<cmd>Telescope undo<cr>",
    desc = "Undo History",
  },
  {
    "<leader>sN",
    function()
      require("telescope").extensions.notify.notify()
    end,
    desc = "Search Notifications",
  },
}

return M

