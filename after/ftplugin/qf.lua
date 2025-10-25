vim.wo.wrap = true
vim.opt_local.spell = false

local function qf_delete_entry()
  local current = vim.fn.line(".")
  local qflist = vim.fn.getqflist()

  table.remove(qflist, current)
  vim.fn.setqflist(qflist, "r")
  vim.fn.execute(":" .. tostring(current))
end

vim.keymap.set("n", "dd", qf_delete_entry, { buffer = true })
