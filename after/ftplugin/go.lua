local utils = require("utils")
--------------------------------------------------------------------------------

-- fix my habits
utils.ft_abbr("function", "func")
utils.ft_abbr("local", "var")
utils.ft_abbr("boolean", "bool")
utils.ft_abbr("float", "float32")
utils.ft_abbr("--", "//")

vim.keymap.set("n", "<leader>f.", function()
  local new_buffer = vim.api.nvim_create_buf(true, false)
  local file = vim.fn.expand("%")
  vim.api.nvim_buf_set_lines(new_buffer, 0, 1, false, { "Output" })
  vim.fn.jobstart({ "go", "run", file }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(new_buffer, -1, -1, false, data)
      end
    end,
  })
end, { buffer = true, desc="Run File with Go" })
