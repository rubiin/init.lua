local user_icons = require("rubin.icons")
local constants = require("utils.constants")

local M = {}

---@param type string
---@return table
function M.set_lualine_styles(type, opts)
  opts.options.component_separators = "|"
  opts.options.section_separators = ""

  if type == constants.styles.slanted then
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  if type == constants.styles.bubbly then
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  opts.sections.lualine_a = {
    {
      "mode",
      fmt = function(str)
        return user_icons.ui.Target .. (str == "V-LINE" and "VL" or (str == "V-BLOCK" and "VB" or str:sub(1, 1)))
      end,
    },
  }
  opts.sections.lualine_b = {
    {
      "branch",
      cond = M.is_git_repo,
    },
    {
      "diff",
      cond = M.is_git_repo,
      symbols = {
        added = user_icons.git.LineAdded,
        modified = user_icons.git.LineModified,
        removed = user_icons.git.LineRemoved,
      },
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
    },
    {
      "diagnostics",
      symbols = {
        error = user_icons.diagnostics.BoldError,
        hint = user_icons.diagnostics.BoldHint,
        info = user_icons.diagnostics.BoldInfo,
        warn = user_icons.diagnostics.BoldWarn,
      },
    },
  }

  opts.sections.lualine_c = {
    {
      "filename",
      cond = M.buffer_not_empty,
    },
  }

  opts.sections.lualine_x = {
    { "location", icon = user_icons.kinds.Unit, separator = { right = "" } },
    {
      function()
        local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", {
          buf = 0,
        })
        return user_icons.ui.Tab .. shiftwidth
      end,
      cond = M.hide_in_width,
    },
  }
  opts.sections.lualine_y = {
    {
      "o:encoding",
      cond = M.hide_in_width,
      fmt = string.upper,
    },

    {
      "filetype",
      fmt = M.capitalize,
    },
  }
  opts.sections.lualine_z = {
    {
      "fileformat",
      icons_enabled = true,
      symbols = {
        unix = "LF  ",
        dos = "CRLF  ",
        mac = "CR  ",
      },
    },
  }

  table.insert(opts.sections.lualine_z, 2, {
    function()
      local clients = package.loaded["copilot"] and vim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}

      if #clients > 0 then
        local status = require("copilot.status").data.status
        if status == "InProgress" then
          return " "
        elseif status == "Warning" then
          return " "
        else
          return " "
        end
      end
    end,
  })

  return opts
end

return M
