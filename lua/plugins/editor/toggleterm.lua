local root_dir = require('lazyvim.util').root.get()

return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    cmd = { 'ToggleTerm' },
    keys = {
      {
        '<leader>Tf',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, 0, root_dir, 'float')
        end,
        desc = 'ToggleTerm (float root_dir)',
      },
      {
        '<leader>Th',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, 15, root_dir, 'horizontal')
        end,
        desc = 'ToggleTerm (horizontal root_dir)',
      },
      {
        '<leader>Tv',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, vim.o.columns * 0.4, root_dir, 'vertical')
        end,
        desc = 'ToggleTerm (vertical root_dir)',
      },
      {
        '<leader>Ts',
        '<cmd>TermSelect<cr>',
        desc = 'Select term',
      },
      {
        '<leader>Tt',
        function() require('toggleterm').toggle(1, 100, root_dir, 'tab') end,
        desc = 'ToggleTerm (tab root_dir)',
      },
    },
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 0.3,
      -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      direction = 'horizontal' or 'vertical' or 'window' or 'float',
      -- direction = "vertical",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
}
