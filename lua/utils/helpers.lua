local M = {}

local fn = vim.fn
local bo = vim.bo
local api = vim.api

function M.merge_tables(t1,t2)
  for k,v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

-- splits a string into a table
function M.str_split (inputstr, sep)
  if sep == nil then
          sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
          table.insert(t, str)
  end
  return t
end

--- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. "9" for 0.9.1
---@param version number
---@return boolean
function M.is_neovim_version_satified(version)
  return version <= tonumber(vim.version().minor)
end

---checks if a command is available
---@param command string
---@return boolean
function M.is_executable_available(command)
  return fn.executable(command) == 1
end

-- disable plugins
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



-- get the version and date
function M.version_date()
  local version = vim.version()
  local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  local datetime = os.date("%Y/%m/%d %H:%M:%S")

  return print_version .. " " .. datetime
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
function M.lazy_load (plugin)
  api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end


-- check if buffer is empty
function M.buffer_not_empty()
  return fn.empty(fn.expand("%:t")) ~= 1
end

-- check if window width is wide enough for lualine components
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

--- Get root directory of git project or fallback to current directory
---@return string|nil
function M.get_root_directory()
  if M.is_git_repo() then
    return M.get_git_root()
  end

  return fn.getcwd()
end

-- Check if a variable is not empty nor nil
M.is_not_empty = function(s)
  return s ~= nil and s ~= ""
end

return M
