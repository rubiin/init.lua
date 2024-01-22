local styles = {
  slanted = 'slanted',
  bubbly = 'bubbly',
  default = 'default',
}

local used_style = styles.slanted -- this is the default style, change it to the style you want to use from the above list

local helpers = require('utils.helpers')
local icons = require('lazyvim.config').icons

local conditions = {
  is_git_repo = helpers.is_git_repo,
  hide_in_width = helpers.hide_in_width,
  buffer_not_empty = helpers.buffer_not_empty,
}

-- return a table with the options to be passed
local lualine_styles = function(type)
  local opts = {
    options = {},
    sections = {},
  }

  opts.options.component_separators = '|'
  opts.options.section_separators = ''

  if type == styles.slanted then
    opts.options.component_separators = { left = '', right = '' }
    opts.options.section_separators = { left = '', right = '' }
  end

  if type == styles.bubbly then
    opts.options.component_separators = '|'
    opts.options.section_separators = { left = '', right = '' }
  end

  opts.sections.lualine_a = { { 'mode', icon = '' } }
  opts.sections.lualine_b = {
    {
      'branch',
      cond = conditions.is_git_repo,
    },
    {
      'diff',
      cond = conditions.hide_in_width,
      symbols = {
        added = icons.git.added,
        modified = icons.git.modified,
        removed = icons.git.removed,
      },
    },
    {
      'diagnostics',
      symbols = {
        error = icons.diagnostics.Error,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Info,
        warn = icons.diagnostics.Warn,
      },
    },
  }

  opts.sections.lualine_c = {
    {
      'filename',
      cond = conditions.buffer_not_empty,
    },
  }

  opts.sections.lualine_x =
    { { 'location', cond = conditions.buffer_not_empty, icon = '', padding = { left = 1, right = 1 } } }
  opts.sections.lualine_y = {
    {
      'o:encoding',
      cond = conditions.hide_in_width,
      fmt = string.upper,
    },

    {
      'fileformat',
      icons_enabled = true,
      cond = conditions.buffer_not_empty,
      symbols = {
        unix = 'LF ',
        dos = 'CRLF ',
        mac = 'CR ',
      },
    },
  }
  opts.sections.lualine_z = {
    'filetype',
  }
  opts.extensions = {
    'lazy',
    'neo-tree',
  }
  return opts
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    lazy = true,
    opts = lualine_styles(used_style),
  },
}
