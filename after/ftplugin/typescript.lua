vim.opt.shiftwidth = 4

local utils = require("utils")

utils.keymap("n", "<C-a>", function()
  return require("dial.map").inc_normal("typescript")
end, { expr = true, desc = "Increment" })
utils.keymap("n", "<C-x>", function()
  return require("dial.map").dec_normal("typescript")
end, { expr = true, desc = "Descrement" })
utils.keymap("v", "<C-a>", function()
  return require("dial.map").inc_normal("typescript")
end, { expr = true, desc = "Increment" })
utils.keymap("v", "<C-x>", function()
  return require("dial.map").dec_normal("typescript")
end, { expr = true, desc = "Increment" })
