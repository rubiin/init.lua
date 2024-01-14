-- Auto save files

return {

  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",                         -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts={
      execution_message = "" -- if you don't want any message after save
    },
    keys = {
    	{
				"<Leader>ua",
        "<cmd>ASToggle<CR>",
				desc = "Auto save toggle",
			},
    },
  },
}
