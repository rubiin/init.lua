local o = vim.opt

-- TODO: add this to lazy
return {
  -- Zen mode for distraction free editing
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
      window = {
        -- * a percentage of the width / height of the editor when <= 1
        width = 0.8, -- width of the Zen window
        height = 1, -- height of the Zen window
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function()
        local gitsigns = prequire("gitsigns.actions")

        gitsigns.toggle_current_line_blame()
        if LazyVim.has("indent_blankline") then
          local indent_blankline = prequire("indent_blankline.commands")
          indent_blankline.disable()
        end

        o.relativenumber = false
        o.signcolumn = "no"
        gitsigns.refresh()
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        local gitsigns = prequire("gitsigns.actions")
        if LazyVim.has("indent_blankline") then
          local indent_blankline = prequire("indent_blankline.commands")
          indent_blankline.enable()
        end

        gitsigns.toggle_current_line_blame()
        o.relativenumber = true
        o.signcolumn = "yes:2"
        gitsigns.refresh()
      end,
    },
  },
}
