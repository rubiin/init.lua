return {
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    event = 'VeryLazy',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() require('barbecue.ui').toggle(true) end,

    keys = {
      {
        '<Leader>uB',
        function()
          local off = vim.b['barbecue_entries'] == nil
          require('barbecue.ui').toggle(off and true or nil)
        end,
        desc = 'Breadcrumbs toggle',
      },
    },
    opts = function()
      local kind_icons = vim.tbl_map(function(icon) return vim.trim(icon) end, require('lazyvim.config').icons.kinds)
      return {
        theme = 'catppuccin',
        show_modified = true,
        kinds = kind_icons,
      }
    end,
  },
}
