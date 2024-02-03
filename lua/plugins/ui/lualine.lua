-- use a protected call so we don't error out on first use
local status_ok, lualinestyles = pcall(require, "utils.helpers")
if not status_ok then
  print("Please restart neovim after setup")
  return
end

function lualine_styles(type)
  local opts = {
    options = {},
    sections = {},
  }

  opts.options.component_separators = "|"
  opts.options.section_separators = ""

  if type == M.styles.slanted then
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  if type == M.styles.bubbly then
    opts.options.component_separators = "|"
    opts.options.section_separators = { left = "", right = "" }
  end

  opts.sections.lualine_a = { { "mode", icon = "" } }
  opts.sections.lualine_b = {
    {
      "branch",
      cond = M.is_git_repo,
    },
    {
      "diff",
      cond = M.hide_in_width,
      symbols = {
        added = icons.git.added,
        modified = icons.git.modified,
        removed = icons.git.removed,
      },
    },
    {
      "diagnostics",
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
      "filename",
      cond = M.buffer_not_empty,
    },
  }

  opts.sections.lualine_x =
    { { "location", cond = M.buffer_not_empty, icon = "", padding = { left = 1, right = 1 } } }
  opts.sections.lualine_y = {
    {
      "o:encoding",
      cond = M.hide_in_width,
      fmt = string.upper,
    },

    {
      "fileformat",
      icons_enabled = true,
      cond = M.buffer_not_empty,
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
  opts.extensions = {}

  return opts
end

local used_style = lualinestyles.styles.slanted -- this is the default style, change it to the style you want to use from the list
local lualine_styles = lualinestyles.lualine_styles(used_style)

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    lazy = true,
    opts = lualine_styles,
  },
}
