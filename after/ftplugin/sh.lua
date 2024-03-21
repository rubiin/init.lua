local utils = require("utils")
--------------------------------------------------------------------------------

-- fix my habits
utils.ft_abbr("//", "#")
utils.ft_abbr("--", "#")
utils.ft_abbr("delay", "sleep")
utils.ft_abbr("const", "local")


vim.keymap.set("n", "<leader>f.", function()
  local file = vim.fn.expand("%") -- Get the current file name
  local first_line = vim.fn.getline(1) -- Get the first line of the file
  if string.match(first_line, "^#!/") then -- If first line contains shebang
    local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
    vim.cmd("!chmod +x " .. escaped_file) -- Make the file executable
    vim.cmd("vsplit") -- Split the window vertically
    vim.cmd("terminal " .. escaped_file) -- Open terminal and execute the file
    vim.cmd("startinsert") -- Enter insert mode, recommended by echasnovski on Reddit
  else
    vim.cmd("echo 'Not a script. Shebang line not found.'")
  end
end, { desc = "Execute current file in terminal (if it's a script)" })
