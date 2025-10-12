local ft_abbr = require("utils").ft_abbr
--------------------------------------------------------------------------------

-- fix my habits
ft_abbr("//", "#")
ft_abbr("--", "#")
ft_abbr("delay", "sleep")
ft_abbr("const", "local")


local cmd = vim.cmd


vim.keymap.set("n", "<leader>f.", function()
  local file = vim.fn.expand("%") -- Get the current file name
  local first_line = vim.fn.getline(1) -- Get the first line of the file
  if string.match(first_line, "^#!/") then -- If first line contains shebang
    local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
    cmd("!chmod +x " .. escaped_file) -- Make the file executable
    cmd("vsplit") -- Split the window vertically
    cmd("terminal " .. escaped_file) -- Open terminal and execute the file
    cmd("startinsert") -- Enter insert mode, recommended by echasnovski on Reddit
  else
    cmd("echo 'Not a script. Shebang line not found.'")
  end
end, { desc = "Execute current file in terminal (if it's a script)" })
