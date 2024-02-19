local M = {}

local fn, bo, api, cmd, o = vim.fn, vim.bo, vim.api, vim.cmd, vim.opt
local user_icons = require("custom.icons")

M.styles = {
  slanted = "slanted",
  bubbly = "bubbly",
  default = "default",
}

-- Check if a string is empty
---@param s any
function M.is_empty(s)
  return s == nil or s == ""
end

-- Checks if a keymap exists
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@return boolean
function M.check_if_keymap_exists(mode, lhs, rhs)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  local modes = type(mode) == "string" and { mode } or mode

  ---@param m string
  modes = vim.tbl_filter(function(m)
    return not (keys.have and keys:have(lhs, m))
  end, modes)
  if #modes > 0 then
    return true
  end
  return false
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
function M.lualine_styles(type)
  local opts = {
    options = {},
    sections = {},
  }

  opts.options.component_separators = "|"
  opts.options.section_separators = ""

  if type == M.styles.slanted then
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }
  end

  if type == M.styles.bubbly then
    opts.options.component_separators = ""
    opts.options.section_separators = { left = "", right = "" }
  end

  opts.sections.lualine_a = { {
    "mode",
    icon = "",
  } }
  opts.sections.lualine_b = {
    {
      "branch",
      cond = M.is_git_repo,
      separator = { left = "", right = "" },
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
    { "location", cond = M.buffer_not_empty, icon = user_icons.kinds.Unit, separator = { left = "", right = "" } },
    {
      function()
        local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
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
        unix = "LF ",
        dos = "CRLF ",
        mac = "CR ",
      },
    },
  }
  opts.sections.lualine_z = {
    "copilot",
    {
      "filetype",
      fmt = M.capitalize,
      cond = M.buffer_not_empty,
      separator = { left = "", right = "" },
    },
  }

  opts.extensions = {}

  return opts
end

-- Toggle dark mode
function M.toggle_light_dark_theme()
  if o.background == "light" then
    o.background = "dark"
    cmd([[Catppuccin mocha]])
  else
    o.background = "light"
    cmd([[Catppuccin latte]])
  end
end

-- Splits a string into a table
---@param value string
---@param sep string
---@return table
function M.str_split(value, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(value, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

-- Check if the minimum Neovim version is satisfied
-- Expects only the minor version, e.g. '9' for 0.9.1
---@param version number
---@return boolean
function M.is_neovim_version_satisfied(version)
  return version <= tonumber(vim.version().minor)
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
---@param level string|integer
---@param title string
function M.notify(message, level, title, timeout)
  local notify_options = {
    title = title,
    timeout = timeout or 2000,
  }
  vim.notify(message, level, notify_options)
end

-- Delete multiple keymaps.
---@param list table
---@return nil
function M.delete_keymaps(list)
  if list == {} then
    return
  end

  for _, keymap in ipairs(list) do
    vim.keymap.del(keymap[1], keymap[2])
  end
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
  vim.keymap.set(mode, lhs, rhs, M.merge(defaults, opts or {}))
end

-- Merge two tables recursively.
---@return table
function M.merge(...)
  return vim.tbl_deep_extend("force", ...)
end

-- Opens the given url in the default browser.
---@param url string: The url to open.
function M.open_in_browser(url)
  local open_cmd
  if fn.executable("xdg-open") == 1 then
    open_cmd = "xdg-open"
  elseif fn.executable("explorer") == 1 then
    open_cmd = "explorer"
  elseif fn.executable("open") == 1 then
    open_cmd = "open"
  elseif fn.executable("wslview") == 1 then
    open_cmd = "wslview"
  end

  local ret = fn.jobstart({ open_cmd, url }, { detach = true })
  if ret <= 0 then
    vim.notify(
      string.format("Failed to open '%s'\nwith command: '%s' (ret: '%d')", url, open_cmd, ret),
      vim.log.levels.ERROR,
      { title = "utils" }
    )
  end
end

-- Open URL under cursor, supports http, https and www
function M.open_url()
  -- Get the text under the cursor
  local url = fn.expand("<cWORD>")

  -- Check if it resembles a URL
  if url:match("^http://") or url:match("^https?://") or url:match("^www%.[%w_-]+%.%w+") then
    -- Open the URL in the default browser
    M.open_in_browser(url)
  else
    print("No URL found under cursor")
  end
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
          icon = require("custom.icons").diagnostics.BoldWarn,
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

-- Capitalize the first letter of a string.
---@param str string
---@return string
function M.capitalize(str)
  return (str:gsub("^%l", string.upper))
end

-- Returns the length of a table.
---@param t table
---@return integer
function M.table_length(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

-- Always ask before exiting nvim, even if there is nothing to be saved.
function M.confirm_quit()
  local choice = fn.confirm("Do you really want to exit nvim?", "&Yes\n&No", 2)
  if choice == 1 then
    -- If user confirms, but there are still files to be saved: Ask
    cmd("confirm quit")
  end
end

-- Search for TODOs in the project
-- Populate quickfixlist with the results
function M.search_todos()
  -- Use ripgrep to search for TODOs in the project, without the end colon you will get a lot of false positives
  -- This is taken from the todo-comments.nvim source code
  local result = fn.system(
    "rg --json --color=never --no-heading --with-filename --line-number --column -w 'TODO:|HACK:|WARN:|PERF:|FIX:|NOTE:|TEST:'"
  )
  if result == nil then
    return
  end
  local lines = vim.split(result, "\n")
  local qf_list = {}

  for _, line in ipairs(lines) do
    if line ~= "" then
      local data = fn.json_decode(line)
      if data ~= nil then
        if data.type == "match" then
          local submatches = data.data.submatches[1]
          table.insert(qf_list, {
            filename = data.data.path.text,
            lnum = data.data.line_number,
            col = submatches.start,
            text = data.data.lines.text,
          })
        end
      end
    end
  end

  if next(qf_list) ~= nil then
    fn.setqflist(qf_list)
    cmd("copen")
    M.notify("Added Todos to Quickfixlist!", vim.log.levels.INFO, "TODOs")
  else
    M.notify("No results found!", vim.log.levels.INFO, "TODOs")
  end
end

return M
