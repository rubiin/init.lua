-- create colorscheme here: https://mswift42.github.io/themecreator/

local util = require("utils")

-- these are neovim built-in colorscheme
local builtins = {}

for name, _ in vim.fs.dir(vim.env.VIMRUNTIME .. "/colors") do
  if not name:match("%.txt$") then
    local base = name:match("^(.*)%.lua$") or name:match("^(.*)%.vim$")
    if base then
      table.insert(builtins, base)
    end
  end
end

local get_colorscheme = function()
  local target = vim.fn.getcompletion

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.getcompletion = function()
    return vim.tbl_filter(function(color)
      return not vim.tbl_contains(builtins, color)
      ---@diagnostic disable-next-line: param-type-mismatch
    end, target("", "color"))
  end

  LazyVim.pick("colorscheme", { enable_preview = true })()
  vim.fn.getcompletion = target
end

-- A list of colorscheme plugin you may want to try. Find what suits you.
return {
  -- add onedarkpro
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   lazy = true,
  --   keys = {
  --     { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
  --   },
  -- },

  -- add vscode
  -- {
  --   "askfiy/visual_studio_code",
  --   priority = 100,
  --   lazy = true,
  --   keys = {
  --     { "<leader>uC", get_colorscheme, desc = "Colorscheme With Preview" },
  --   },
  -- },
  -- add material
  -- {
  --   "marko-cerovac/material.nvim",
  --   lazy = true,
  --   keys = {
  --     { "<leader>uC", get_colorsheme, desc = "Colorscheme With Preview" },
  --   },
  -- },
}
