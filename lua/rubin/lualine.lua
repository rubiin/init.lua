local user_icons = require("rubin.icons")
local constants = require("rubin.constants")
local utils = require("utils")

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
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  if type == constants.styles.powerline then
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  if type == constants.styles.nerd then
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  if type == constants.styles.slanted_reverse then
    opts.options.component_separators = { left = "|", right = "|" }
    opts.options.section_separators = { left = "", right = "" }
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
      cond = utils.is_git_repo and utils.is_file_window,
      on_click = function()
        Snacks.notify("add branch picker")
      end,
    },
    {
      "diff",
      cond = utils.is_git_repo and utils.is_file_window,
      on_click = function()
        Snacks.picker.git_diff()
      end,
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
  }

  opts.sections.lualine_c = {
    {
      "diagnostics",
      on_click = function()
        vim.cmd("Trouble diagnostics toggle")
      end,
      symbols = {
        error = user_icons.diagnostics.BoldError,
        hint = user_icons.diagnostics.BoldHint,
        info = user_icons.diagnostics.BoldInfo,
        warn = user_icons.diagnostics.BoldWarn,
      },
    },
    LazyVim.lualine.root_dir(),
    {
      LazyVim.lualine.pretty_path({ length = 5 }),
      color = { fg = "#D7D7BC" },
      separator = "",
      cond = utils.is_file_window and utils.hide_in_width,
      on_click = function()
        vim.g.trouble_lualine = not vim.g.trouble_lualine
        require("lualine").refresh()
      end,
    },
  }

  opts.sections.lualine_x = {
    {
      require("lazy.status").updates,
      cond = require("lazy.status").has_updates and utils.hide_in_width,
      color = function()
        return { fg = Snacks.util.color("Comment") }
      end,
      on_click = function()
        vim.cmd([[Lazy]])
      end,
    },
    { "location", icon = LazyVim.config.icons.kinds.Unit, separator = { right = "" } },
    {
      function()
        local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", {
          buf = 0,
        })
        return user_icons.ui.Tab .. shiftwidth
      end,
      cond = utils.hide_in_width,
    },
  }
  opts.sections.lualine_y = {
    {
      "o:encoding",
      cond = utils.hide_in_width,
      fmt = string.upper,
    },

    {
      "filetype",
      fmt = utils.capitalize,
      cond = utils.is_file_window,
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
