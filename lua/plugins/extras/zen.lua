local o = vim.opt

return {
  -- Dims inactive portions of the code you're editing
  {
    "folke/twilight.nvim",
    lazy = true,
    event = "VeryLazy",
    cmd = "Twilight",
  },
  -- Zen mode for distraction free editing
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    lazy = true,
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        width = 0.8, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = 'no', -- disable signcolumn -- handled on the on_open and on_close hooks
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers -- handled on the on_open and on_close hooks
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = '0', -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        alacritty = {
          enabled = true,
          font = "14", -- font size
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function()
        local gitsigns = prequire("gitsigns.actions")

        gitsigns.toggle_current_line_blame()

        local indent_blankline = prequire("indent_blankline.commands")

        indent_blankline.disable()

        o.relativenumber = false
        o.signcolumn = "no"
        gitsigns.refresh()
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        local gitsigns = prequire("gitsigns.actions")

        local indent_blankline = prequire("indent_blankline.commands")

        gitsigns.toggle_current_line_blame()
        indent_blankline.enable()
        o.relativenumber = true
        o.signcolumn = "yes:2"
        gitsigns.refresh()
      end,
    },
  },
}

-- TODO: look into this plugins
