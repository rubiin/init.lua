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

M.biome_config_path = function()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/biome.json"
  if vim.fn.filereadable(config_file) == 1 then
    return current_dir
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a biome.json file
  local git_root = M.get_git_root()
  if M.is_git_repo() and git_root ~= current_dir then
    config_file = git_root .. "/biome.json"
    if vim.fn.filereadable(config_file) == 1 then
      return git_root
    end
  end

  return nil
end

M.biome_config_exists = function()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/biome.json"
  if vim.fn.filereadable(config_file) == 1 then
    return true
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a biome.json file
  local git_root = M.get_git_root()
  if M.is_git_repo() and git_root ~= current_dir then
    config_file = git_root .. "/biome.json"
    if vim.fn.filereadable(config_file) == 1 then
      return true
    end
  end

  return false
end

M.deno_config_exist = function()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/deno.json"
  if vim.fn.filereadable(config_file) == 1 then
    return true
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a deno.json file
  local git_root = M.get_git_root()
  if M.is_git_repo() and git_root ~= current_dir then
    config_file = git_root .. "/deno.json"
    if vim.fn.filereadable(config_file) == 1 then
      return true
    end
  end

  return false
end

M.eslint_config_exists = function()
  local current_dir = vim.fn.getcwd()
  local config_files =
    { ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json", ".eslintrc" }

  for _, file in ipairs(config_files) do
    local config_file = current_dir .. "/" .. file
    if vim.fn.filereadable(config_file) == 1 then
      return true
    end
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a eslint config file
  local git_root = M.get_git_root()
  if M.is_git_repo() and git_root ~= current_dir then
    for _, file in ipairs(config_files) do
      local config_file = git_root .. "/" .. file
      if vim.fn.filereadable(config_file) == 1 then
        return true
      end
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

-- Taken from ThePrimeagen and modified
---@param color string
function M.color_my_pencils(color)
  color = color or "catppuccin"
  cmd.colorscheme(color)

  api.nvim_set_hl(0, "Normal", { bg = "none" })
  api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

---@param type string
---@return table
function M.set_lualine_styles(type)
  local opts = {
    options = {},
    sections = {},
    winbar = {},
  }

  opts.options.component_separators = "|"
  opts.options.section_separators = ""

  if type == constants.styles.slanted then
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  if type == constants.styles.bubbly then
    opts.options.component_separators = ""
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
    },
  }

  opts.sections.lualine_x = {
    { "location", cond = M.buffer_not_empty, icon = user_icons.kinds.Unit, separator = { right = "" } },
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
      cond = M.buffer_not_empty,
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
      cond = M.buffer_not_empty,
    },
  }

  opts.extensions = {}

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

-- Get the version of neovim
---@return string
function M.version()
  local version = vim.version()
  local print_version = version.major .. "." .. version.minor .. "." .. version.patch

  return user_icons.ui.Neovim .. print_version
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

-- Delete keymap.
---@param keymap list
---@return nil
function M.delete_keymap(keymap)
  vim.keymap.del(keymap[1], keymap[2])
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
---@return boolean
function M.hide_in_width()
  return fn.winwidth(0) > 100
end

-- Check if current directory is a git repo.
---@return boolean
function M.is_git_repo()
  local filepath = fn.expand("%:p:h")
  local gitdir = fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

-- Get root directory of git project
---@return string|nil
function M.get_git_root()
  local dot_git_path = fn.finddir(".git", ".;")
  return fn.fnamemodify(dot_git_path, ":h")
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

-- Get root directory of git project or fallback to current directory.
---@return string|nil
function M.get_root_directory()
  if M.is_git_repo() then
    return M.get_git_root()
  end

  return fn.getcwd()
end

-- Check if a variable is not empty nor nil.
---@param s string
---@return boolean
function M.is_not_empty(s)
  return s ~= nil and s ~= ""
end

-- Check if a variable is empty or nil.
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table?
function M.keymap(mode, lhs, rhs, opts)
  local defaults = {
    silent = true,
    noremap = true,
  }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", defaults, opts or {}))
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
  vim.keymap.set("ia", lhs, rhs, { buffer = true })
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

-- Taken from folke's dotfiles.
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
      if count >= 10 and bo.buftype ~= "nofile" then
        ok, id = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
          icon = require("rubin.icons").diagnostics.BoldWarn,
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
