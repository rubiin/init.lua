return {
  "catgoose/nvim-colorizer.lua",
  event = "VeryLazy",
  opts = { -- set to setup table
    filetypes = { "*" },
    buftypes = {},
    user_commands = true,
    lazy_load = false,
    options = {
      parsers = {
        css = false, -- preset: enables names, hex, rgb, hsl, oklch
        css_fn = false, -- preset: enables rgb, hsl, oklch
        names = {
          enable = false,
          lowercase = true,
          camelcase = true,
          uppercase = false,
          strip_digits = false,
          custom = false, -- table|function|false
        },
        hex = {
          default = false, -- default value for format keys (see above)
          rgb = false, -- #RGB
          rgba = false, -- #RGBA
          rrggbb = false, -- #RRGGBB
          rrggbbaa = false, -- #RRGGBBAA
          aarrggbb = false, -- 0xAARRGGBB
        },
        rgb = { enable = false },
        hsl = { enable = false },
        oklch = { enable = false },
        tailwind = {
          enable = false, -- parse Tailwind color names
          lsp = false, -- use Tailwind LSP documentColor
          update_names = false,
        },
        sass = {
          enable = false,
          parsers = { css = true },
          variable_pattern = "^%$([%w_-]+)",
        },
        xterm = { enable = false },
        custom = {},
      },
      display = {
        mode = "background", -- "background"|"foreground"|"virtualtext"
        background = {
          bright_fg = "#000000",
          dark_fg = "#ffffff",
        },
        virtualtext = {
          char = "■",
          position = "eol", -- "eol"|"before"|"after"
          hl_mode = "foreground",
        },
        priority = {
          default = 150, -- vim.hl.priorities.diagnostics
          lsp = 200, -- vim.hl.priorities.user
        },
      },
      hooks = {
        should_highlight_line = false, -- function(line, bufnr, line_num) -> bool
      },
      always_update = false,
    },
  },
}
