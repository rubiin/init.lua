return {
  -- zoom
  {
    "echasnovski/mini.misc",
    config = true,
    lazy = true,
    event = "VeryLazy",
      --stylua: ignore
      keys = {
        {
          '<leader>uz',
          function()
            require('mini.misc').zoom()
          end,
          desc = 'Toggle Zoom'
        }
      },
  },
}
