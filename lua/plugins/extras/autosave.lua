-- Auto save files

return {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    lazy = true,
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    keys = {
      {
        "<Leader>ua",
        "<cmd>ASToggle<CR>",
        desc = "Toggle Auto Save",
      },
    },
    opts = {
      execution_message = "", -- if you don't want any message after save
    },
  },
}
