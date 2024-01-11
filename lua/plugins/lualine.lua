local style = "one" -- this keeps the default config, change this to another style name to use it

local lualine_styles = {
  one = function(_, opts)
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }

    table.remove(opts.sections.lualine_x, 1)
    opts.sections.lualine_a = { { "mode", icon = "" } }
    opts.sections.lualine_c = {
      "filename"
    }
    opts.sections.lualine_x = { { "location", icon = "", padding = { left = 1, right = 1 } } }
    opts.sections.lualine_y = { "encoding" }
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
