local keys = { quit = { '<esc>', 'q' }, toggle_or_jump = { '<cr>', 'o' } }

-- when you are lua newbie, you can use this
-- might replace with lsp-zero
return {
  {
    'nvimdev/lspsaga.nvim',
    event = { 'BufReadPost' },
    cmd = 'Lspsaga',
    config = function(_, opts) require('lspsaga').setup(opts) end,
    opts = {
      callhierarchy = { silent = true, keys = { quit = keys.quit } },
      definition = { silent = true, keys = { quit = keys.quit } },
      diagnostic = { enable = true, keys = { quit = keys.quit } },
      finder = { silent = true, keys = { quit = keys.quit, toggle_or_open = keys.toggle_or_jump } },
      outline = { silent = true, keys = keys },
      lightbulb = { enable = true },
      symbol_in_winbar = { enable = false, show_file = true, hide_keyword = false, folder_level = 0 },

      --- disabled lspsaga features
      hover = { enable = false },
      code_action = { enable = false, extend_gitsigns = true },
      rename = { enable = false },
    },
    keys = {
      { '<leader>lj', '<Cmd>Lspsaga finder<CR>', desc = 'Lspsaga Finder' },
      { '<leader>lp', '<Cmd>Lspsaga peek_definition<CR>', desc = 'Lspsaga Peek Definition' },
      { '<leader>lo', '<Cmd>Lspsaga outline<CR>', desc = 'Lspsaga outline' },
      { '<leader>lI', '<Cmd>Lspsaga incoming_calls<CR>', desc = 'Lspsaga Incoming Calls' },
      { '<leader>lO', '<Cmd>Lspsaga outgoing_calls<CR>', desc = 'Lspsaga Outgoing Calls' },
      { '<leader>lS', '<Cmd>Lspsaga outline<CR>', desc = 'Lspsaga Outline Toggle' },
    },
  },
  {
    'RRethy/vim-illuminate',
    opts = {
      filetypes_denylist = {
        'sagafinder',
        'sagacallhierarchy',
        'sagaincomingcalls',
        'sagapeekdefinition',
        'sagaoutline',
      },
    },
  },
}
