local M = {}

local fn, bo, api, cmd, o = vim.fn, vim.bo, vim.api, vim.cmd, vim.opt
local icons = require("utils.icons")

M.styles = {
  slanted = "slanted",
  bubbly = "bubbly",
  default = "default",
}

-- taken from ThePrimeagen and modified
function M.ColorMyPencils(color)
  color = color or "catppuccin"
  cmd.colorscheme(color)

  api.nvim_set_hl(0, "Normal", { bg = "none" })
  api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

--- @param type string
--- @return table
function M.lualine_styles(type)
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
        added = icons.git.LineAdded,
        modified = icons.git.LineModified,
        removed = icons.git.LineRemoved,
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

-- toggle dark mode
function M.toggle_light_dark_theme()
  if o.background == "light" then
    o.background = "dark"
    cmd([[Catppuccin mocha]])
  else
    o.background = "light"
    cmd([[Catppuccin latte]])
  end
end

-- splits a string into a table
--- @param inputstr string
--- @param sep string
--- @return table
function M.str_split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

-- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. '9' for 0.9.1
--- @param version number
---@return boolean
function M.is_neovim_version_satisfied(version)
  return version <= tonumber(vim.version().minor)
end

---checks if a command is available
---@param command string
---@return boolean
function M.is_executable_available(command)
  return fn.executable(command) == 1
end

-- disable plugins
--- @param list table
--- @return table
function M.disable_plugins(list)
  local disabled_plugins = {}
  for _, plugin in ipairs(list) do
    table.insert(disabled_plugins, {
      plugin,
      enabled = false,
    })
  end
  return disabled_plugins
end

-- get the version of neovim
--- @return string
function M.version()
  local version = vim.version()
  local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch

  return " " .. print_version .. " "
end

---notify
---@param message string
---@param level integer
---@param title string
M.notify = function(message, level, title)
  local notify_options = {
    title = title,
    timeout = 2000,
  }
  api.nvim_notify(message, level, notify_options)
end

function M.delete_keymaps(list)
  if list == {} or list == nil then
    return
  end

  for _, keymap in ipairs(list) do
    vim.keymap.del(keymap[1], keymap[2])
  end
end

function M.config_exists(filename)
  local current_dir = fn.getcwd()
  local config_file = current_dir .. "/" .. filename
  if fn.filereadable(config_file) == 1 then
    return true
  end
end

-- Trim trailing whitespace and trailing blank lines on save
function M.trim_trailing_whitespace()
  local pos = api.nvim_win_get_cursor(0)
  cmd([[silent keepjumps keeppatterns %s/\s\+$//e]])
  api.nvim_win_set_cursor(0, pos)
end

function M.trim_trailing_lines()
  local last_line = api.nvim_buf_line_count(0)
  local last_nonblank_line = fn.prevnonblank(last_line)
  if last_nonblank_line < last_line then
    api.nvim_buf_set_lines(0, last_nonblank_line, last_line, true, {})
  end
end

function M.trim()
  if not o.binary and o.filetype ~= "diff" then
    M.trim_trailing_lines()
    M.trim_trailing_whitespace()
  end
end

-- check if buffer is empty
---@return boolean
function M.buffer_not_empty()
  return fn.empty(fn.expand("%:t")) ~= 1
end

-- check if window width is wide enough for lualine components
---@return boolean
function M.hide_in_width()
  return fn.winwidth(0) > 80
end

--- Check if current directory is a git repo
---@return boolean
function M.is_git_repo()
  local filepath = fn.expand("%:p:h")
  local gitdir = fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

--- Get root directory of git project
---@return string|nil
function M.get_git_root()
  local dot_git_path = fn.finddir(".git", ".;")
  return fn.fnamemodify(dot_git_path, ":h")
end

-- lua line component for lazy
---@return table
function M.lazy_lua_component()
  return {
    require("lazy.status").updates,
    cond = require("lazy.status").has_updates,
    color = { fg = "#ff9e64" },
  }
end

--- Get root directory of git project or fallback to current directory
---@return string|nil
function M.get_root_directory()
  if M.is_git_repo() then
    return M.get_git_root()
  end

  return fn.getcwd()
end

-- Check if a variable is not empty nor nil
---@param s string
---@return boolean
function M.is_not_empty(s)
  return s ~= nil and s ~= ""
end

-- Check if a variable is empty or nil
function M.keymap(mode, lhs, rhs, opts)
  local defaults = {
    silent = true,
    noremap = true,
  }
  vim.keymap.set(mode, lhs, rhs, M.merge(defaults, opts or {}))
end

-- Merge two tables recursively
---@return table
function M.merge(...)
  return vim.tbl_deep_extend("force", ...)
end

--- Extend a table of lists by key.
---@param table table The table to extend.
---@param keys table List of keys to extend.
---@param values table The values to extend the table with.
function M.extend_keys(table, keys, values)
  table = table or {}
  for _, key in ipairs(keys) do
    table[key] = vim.list_extend(table[key] or {}, values)
  end
  return table
end

-- Taken from folke's dotfiles
function M.cowboy()
  ---@type table?
  local id
  local ok = true
  for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do
    local count = 0
    local timer = assert(vim.loop.new_timer())
    local map = key
    vim.keymap.set("n", key, function()
      if vim.v.count > 0 then
        count = 0
      end
      if count >= 10 and vim.bo.buftype ~= "nofile" then
        ok, id = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
          icon = require("utils.icons").diagnostics.Warn,
          replace = id,
          keep = function()
            return count >= 10
          end,
        })
        if not ok then
          id = nil
          return map
        end
      else
        count = count + 1
        timer:start(2000, 0, function()
          count = 0
        end)
        return map
      end
    end, { expr = true, silent = true })
  end
end

return M
