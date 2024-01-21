local M = {}

local fn = vim.fn
local bo = vim.bo
local api = vim.api


-- toggle dark mode
function M.toggle_light_dark_theme()
	if vim.o.background == "light" then
		vim.o.background = "dark"
		vim.cmd([[Catppuccin mocha]])
	else
		vim.o.background = "light"
		vim.cmd([[Catppuccin latte]])
	end
end


-- splits a string into a table
--- @param inputstr string
--- @param sep string
--- @return table
function M.str_split(inputstr, sep)
  if sep == nil then sep = '%s' end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

-- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. '9' for 0.9.1
--- @param version number
---@return boolean
function M.is_neovim_version_satified(version) return version <= tonumber(vim.version().minor) end

---checks if a command is available
---@param command string
---@return boolean
function M.is_executable_available(command) return fn.executable(command) == 1 end

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
  local print_version = 'v' .. version.major .. '.' .. version.minor .. '.' .. version.patch

  return ' ' .. print_version .. ' '
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

-- lazy load plugins , taken from NVchads config
function M.lazy_load(plugin)
  api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
    group = api.nvim_create_augroup('BeLazyOnFileOpen' .. plugin, {}),
    callback = function()
      local file = fn.expand('%')
      local condition = file ~= 'NvimTree_1' and file ~= '[lazy]' and file ~= ''

      if condition then
        api.nvim_del_augroup_by_name('BeLazyOnFileOpen' .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do 'nvim filename'
        if plugin ~= 'nvim-treesitter' then
          vim.schedule(function()
            require('lazy').load({ plugins = plugin })

            if plugin == 'nvim-lspconfig' then vim.cmd('silent! do FileType') end
          end, 0)
        else
          require('lazy').load({ plugins = plugin })
        end
      end
    end,
  })
end

-- check if buffer is empty
---@return boolean
function M.buffer_not_empty() return fn.empty(fn.expand('%:t')) ~= 1 end

-- check if window width is wide enough for lualine components
---@return boolean
function M.hide_in_width() return fn.winwidth(0) > 80 end

--- Check if current directory is a git repo
---@return boolean
function M.is_git_repo()
  local filepath = fn.expand('%:p:h')
  local gitdir = fn.finddir('.git', filepath .. ';')
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

--- Get root directory of git project
---@return string|nil
function M.get_git_root()
  local dot_git_path = fn.finddir('.git', '.;')
  return fn.fnamemodify(dot_git_path, ':h')
end

-- lua line component for lazy
---@return table
function M.lazy_lua_component()
  return {
    require('lazy.status').updates,
    cond = require('lazy.status').has_updates,
    color = { fg = '#ff9e64' },
  }
end

--- Get root directory of git project or fallback to current directory
---@return string|nil
function M.get_root_directory()
  if M.is_git_repo() then return M.get_git_root() end

  return fn.getcwd()
end

-- Check if a variable is not empty nor nil
---@param s string
---@return boolean
function M.is_not_empty(s)
  return s ~= nil and s ~= ''
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
  return vim.tbl_deep_extend('force', ...)
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

return M
