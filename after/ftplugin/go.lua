local utils = require("utils")
--------------------------------------------------------------------------------

-- fix my habits
utils.ft_abbr("function", "func")
utils.ft_abbr("local", "var")
utils.ft_abbr("boolean", "bool")
utils.ft_abbr("float", "float32")
utils.ft_abbr("--", "//")


vim.keymap.set("n", "<leader>f.", function()
  local file = vim.fn.expand("%") -- Get the current file name
    local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
    vim.cmd("!chmod +x " .. escaped_file) -- Make the file executable
    vim.cmd("vsplit") -- Split the window vertically
    vim.cmd("terminal " .. escaped_file) -- Open terminal and execute the file
    vim.cmd("startinsert") -- Enter insert mode, recommended by echasnovski on Reddit

end, { desc = "Execute current file in terminal (if it's a script)" })
