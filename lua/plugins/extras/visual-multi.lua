return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "LazyFile",
    lazy = true,
    init = function()
      vim.g.VM_theme = "purplegray"
      vim.g.VM_mouse_mappings = 1
    end,
  },
}
