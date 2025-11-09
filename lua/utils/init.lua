local M = {}

local fn, bo, api, cmd, o = vim.fn, vim.bo, vim.api, vim.cmd, vim.opt
local constants = require("utils.constants")
local user_icons = require("rubin.icons")

-- Gets the operating system
function M.get_os()
  local os = vim.loop.os_uname().sysname
  if os == "Darwin" then
    return "macOS"
  end
  if os:match("Windows") then
    return "Windows"
  end

  return os
end

--- Check if it's day time
---@return boolean
function M.is_day_time()
  local hour = tonumber(os.date("%H"))
  return hour >= 9 and hour < 19
end

---Check if buffer is valid
---@param buf_id number
---@return boolean
M.is_valid_buf = function(buf_id)
  return type(buf_id) == "number" and vim.api.nvim_buf_is_valid(buf_id)
end

--- Check if it's WarpTerminal
---@return boolean
function M.is_warp_terminal()
  return os.getenv("TERM_PROGRAM") == "WarpTerminal"
end

-- Check if CLI config exists
---@param config_files table
---@return boolean
M.cli_config_exists = function(config_files)
  local current_dir = vim.fn.getcwd()
  local root = LazyVim.root.get({ normalize = true })

  if root ~= current_dir then
    return false
  end

  -- helper to check if any of the provided files exist in a given directory
  local function has_config(dir)
    for _, file in ipairs(config_files or {}) do
      local path = dir .. "/" .. file
      if vim.fn.filereadable(path) == 1 then
        return true
      end
    end
    return false
  end

  -- 1. check current directory
  if has_config(current_dir) then
    return true
  end

  -- 2. check git root if applicable
  local git_root = LazyVim.root.git()
  if M.is_git_repo() and git_root ~= current_dir then
    if has_config(git_root) then
      return true
    end
  end

  return false
end
-- Create augroup
---@param name string
---@param opts? table
---@return number
function M.augroup(name, opts)
  opts = opts or { clear = true }
  return api.nvim_create_augroup(name, opts)
end

local file_big_cache = {}

--- check if the buffer is big
---@param buffer any
---@param max_size? number
---@return boolean
M.is_file_big = function(buffer, max_size)
  if file_big_cache[buffer] ~= nil then
    return file_big_cache[buffer]
  end

  local max_bytes = max_size or (100 * 1024)
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))
  local big = ok and stats and stats.size > max_bytes
  file_big_cache[buffer] = big
  return big
end

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
      "fileformat",
      icons_enabled = true,
      symbols = {
        unix = "LF  ",
        dos = "CRLF  ",
        mac = "CR  ",
      },
    },
  }
  opts.sections.lualine_z = {
    {
      "filetype",
      fmt = M.capitalize,
    },
  }

  table.insert(
    opts.sections.lualine_z,
    2,
    LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
      local clients = package.loaded["copilot"] and vim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
      if #clients > 0 then
        local status = require("copilot.status").data.status
        return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
      end
    end)
  )

  return opts
end

-- Splits a string into a table
---@param str string
---@param delimiter string
---@return table
function M.str_split(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

-- Check if the minimum Neovim version is satisfied
-- Expects only the minor version, e.g. '9' for 0.9.1
---@param version number
---@return boolean
function M.is_neovim_version_satisfied(version)
  return version <= tonumber(vim.version().minor)
end

--- Get neovim version
---@return string
function M.neovim_version()
  local version = vim.version()
  return version.major .. "." .. version.minor .. "." .. version.patch
end

-- Checks if a command is available
---@param command string
---@return boolean
function M.is_installed(command)
  return fn.executable(command) == 1
end

-- Disable plugins
---@param list table
---@return table
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

-- Notify
---@param message string
---@param level string|number
---@param title? string
---@param timeout? number
function M.notify(message, level, title, timeout)
  local notify_options = {
    title = title or "notification",
    timeout = timeout or 2000,
  }
  vim.notify(message, level, notify_options)
end

-- Trim trailing whitespace on save.
function M.trim_trailing_whitespace()
  local pos = api.nvim_win_get_cursor(0)
  cmd([[silent keepjumps keeppatterns %s/\s\+$//e]])
  api.nvim_win_set_cursor(0, pos)
end

-- Trim trailing blank lines on save.
function M.trim_trailing_lines()
  local last_line = api.nvim_buf_line_count(0)
  local last_nonblank_line = fn.prevnonblank(last_line)
  if last_nonblank_line < last_line then
    api.nvim_buf_set_lines(0, last_nonblank_line, last_line, true, {})
  end
end

-- Trim trailing whitespace and blank lines on save.
function M.trim()
  if not o.binary and o.filetype ~= "diff" then
    M.trim_trailing_lines()
    M.trim_trailing_whitespace()
  end
end

-- Check if buffer is empty.
---@return boolean
function M.buffer_not_empty()
  return fn.empty(fn.expand("%:t")) ~= 1
end

-- Check if window width is wide enough for lualine components.
---@param width? number
---@return boolean
function M.hide_in_width(width)
  return fn.winwidth(0) > (width or 100)
end

-- Check if current directory is a git repo.
---@return boolean
function M.is_git_repo()
  local filepath = fn.expand("%:p:h")
  local gitdir = fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

-- Lua line component for lazy.
---@return table
function M.lazy_lua_component()
  return {
    require("lazy.status").updates,
    cond = require("lazy.status").has_updates,
    color = { fg = "#ff9e64" },
  }
end

-- Check if a variable is not empty nor nil.
---@param s string
---@return boolean
function M.is_not_empty(s)
  return s ~= nil and s ~= ""
end

--- Checks whether the buffer is valid.
-- Checks if buffer is valid and listed.
---@param buf_id buffer id to be checked.
---@return boolean
function M.is_valid_buffer(buf_id)
  return api.nvim_buf_is_valid(buf_id) and fn.getbufvar(buf_id, "&buflisted") == 1
end

--- Checks whether the buffer is a regular file buffer.
-- It also checks if buffer is valid and listed.
---@param buf_id buffer id to be checked.
---@return boolean
function M.is_file_buffer(buf_id)
  return M.is_valid_buffer(buf_id) and fn.getbufvar(buf_id, "&buftype") ~= "terminal"
end

-- Checks whether the buffer is regular file buffer.
--- It also checks if buffer is valid and listed.
function M.get_active_buffers()
  local bufs = api.nvim_list_bufs()
  local active_buffers = {}
  local count = 0
  for idx, buf_id in pairs(bufs) do
    if M.is_file_buffer(buf_id) then
      count = count + 1
      active_buffers[count] = buf_id
    end
  end
  return active_buffers
end

-- Very useful for polygot programmers correct their habits
-- from
function M.ft_abbr(lhs, rhs)
  Snacks.keymap.set("ia", lhs, rhs, { buffer = true })
end

-- Extend a table of lists by key.
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

-- Checks if a list contains a value.
---@param list table
---@param val any
---@return boolean
function M.list_contains(list, val)
  for i = 1, #list do
    if list[i] == val then
      return true
    end
  end
  return false
end

-- Capitalize the first letter of a string.
---@param str string
---@return string
function M.capitalize(str)
  return (str:gsub("^%l", string.upper))
end

-- Always ask before exiting nvim, even if there is nothing to be saved.
function M.confirm_quit()
  local choice = fn.confirm("Do you really want to exit nvim?", "&Yes\n&No", 2)
  if choice == 1 then
    -- If user confirms, but there are still files to be saved: Ask
    cmd("confirm quit")
  end
end

-- Print a value
function M.P(v)
  print(vim.inspect(v))
  return v
end

-- Debug Notification
-- (value, context_message)
function M.DN(v, cm)
  local time = os.date("%H:%M")
  local context_msg = cm or " "
  local msg = context_msg .. " " .. time
  vim.notify(vim.inspect(v), "debug", { title = { "Debug Output", msg } })
  return v
end

function M.RELOAD(...)
  return require("plenary.reload").reload_module(...)
end

function M.R(name)
  M.RELOAD(name)
  return require(name)
end

---Try to require the module, and do not error out when one of them cannot be
---loaded, but do notify if there was an error.
---@param module string
---@return any
function M.prequire(module)
  local success, module = pcall(require, module)

  if success then
    return module
  else
    local msg = ("Error loading %s\n%s"):format(module, module)
    vim.defer_fn(function()
      vim.notify(msg, vim.log.levels.ERROR)
    end, 1000)
  end
end

function M.get_resiters()
  -- Execute the :registers command to get the list of registers and store the output in a variable
  local registers_output = vim.fn.getreg('"0')

  -- Print the output
  vim.notify(vim.inspect(registers_output))
end

return M
