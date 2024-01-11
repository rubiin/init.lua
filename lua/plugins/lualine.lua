local style = "one" -- this keeps the default config, change this to another style name to use it

local function truncate(trunc_width, trunc_len, hide_width, trunc_right)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      if not trunc_right then
        return str:sub(1, trunc_len) .. ('...')
      else
        return '...' .. str:sub(#str - trunc_len + 1, #str)
      end
    end
    return str
  end
end

local function using_global_statusline()
  return vim.opt.laststatus:get() == 3
end

local function min_statusline_width(width)
  return function()
    local statusline_width
    if using_global_statusline() then
      -- global statusline: editor width
      statusline_width = vim.opt.columns:get()
    else
      -- local statusline: window width
      statusline_width = vim.fn.winwidth(0)
    end
    return statusline_width > width
  end
end

local function min_window_with(width)
  return function()
    return vim.fn.winwidth(0) > width
  end
end



local lualine_styles = {
  one = function(_, opts)
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }

    table.remove(opts.sections.lualine_x, 1)
    opts.sections.lualine_a = { { "mode", icon = "" , cond = min_statusline_width(40) } }

    opts.sections.lualine_x = { { "location", icon = "", padding = { left = 1, right = 1 } } }
    opts.sections.lualine_y = { "encoding",

      {
        'fileformat',
        icons_enabled = true,
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        },
      } }
    opts.sections.lualine_z = {
      {
        "fileformat",
        symbols = {
          unix = '', -- e712
          dos = '', -- e70f
          mac = '', -- e711
        },
      },
      "filetype",
    }
    opts.extensions = {
      "lazy",
      "man",
      "mason",
      "nvim-dap-ui",
      "overseer",
      "quickfix",
      "toggleterm",
      "trouble",
      "neo-tree",
      "symbols-outline",
    }
  end,

}




return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    opts = lualine_styles[style],

  }
}


-- active_right({
--   "o:encoding",
--   fmt = string.upper,
--   cond = conditions.hide_in_width,
--   padding = { left = 1, right = 1 },
--   color = { bg = colors.blue, fg = colors.black },
-- })
