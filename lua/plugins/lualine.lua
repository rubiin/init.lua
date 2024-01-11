local style = "one" -- this keeps the default config, change this to another style name to use it

local fn = vim.fn


local conditions = {
  buffer_not_empty = function()
    return fn.empty(fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = fn.expand("%:p:h")
    local gitdir = fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local lualine_styles = {
  one = function(_, opts)
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }

    table.remove(opts.sections.lualine_x, 1)

    opts.sections.lualine_a = { { "mode", icon = "" } }
    opts.sections.lualine_b = { {
      "branch",
      cond = conditions.check_git_workspace
    },
      {
        "diff",
        cond = conditions.hide_in_width,
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
      }
      , "diagnostics" }

    opts.sections.lualine_c = {
      {
        "filename",
        cond = conditions.buffer_not_empty
      }
    }


    opts.sections.lualine_x = { { "location", cond = conditions.buffer_not_empty, icon = "", padding = { left = 1, right = 1 } } }
    opts.sections.lualine_y = {
      {
        "o:encoding",
        cond = conditions.hide_in_width,
        fmt = string.upper,
      },

      {
        "fileformat",
        icons_enabled = true,
        cond = conditions.buffer_not_empty,
        symbols = {
          unix = "LF ",
          dos = "CRLF ",
          mac = "CR ",
        },
      },
    }
    opts.sections.lualine_z = {
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
  },
}

-- active_right({
--   "o:encoding",
--   fmt = string.upper,
--   cond = conditions.hide_in_width,
--   padding = { left = 1, right = 1 },
--   color = { bg = colors.blue, fg = colors.black },
-- })
