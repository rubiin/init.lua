local style = "one" -- this keeps the default config, change this to another style name to use it

local helpers = require("utils.helpers")

local conditions = {
  is_git_repo = helpers.is_git_repo,
  hide_in_width = helpers.hide_in_width,
  buffer_not_empty = helpers.buffer_not_empty,
}

local lualine_styles = {
  one = function(_, opts)
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }

    table.remove(opts.sections.lualine_x, 1)

    opts.sections.lualine_a = { { "mode", icon = "" } }
    opts.sections.lualine_b = { {
      "branch",
      cond = conditions.is_git_repo
    },
      {
        "diff",
        cond = conditions.hide_in_width,
        symbols = { added = " ", modified = " ", removed = " " },
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
