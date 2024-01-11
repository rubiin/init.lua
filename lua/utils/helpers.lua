local M = {}

local fn = vim.fn
local bo = vim.bo

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



function M.currentFile()
	local maxLen = 25

	local ext = fn.expand("%:e")
	local ft = bo.filetype
	local name = fn.expand("%:t")
	if ft == "octo" and name:find("^%d$") then
		name = "#" .. name
	elseif ft == "TelescopePrompt" then
		name = "Telescope"
	end

	local deviconsInstalled, devicons = pcall(require, "nvim-web-devicons")
	local ftOrExt = ext ~= "" and ext or ft
	if ftOrExt == "javascript" then ftOrExt = "js" end
	if ftOrExt == "typescript" then ftOrExt = "ts" end
	if ftOrExt == "markdown" then ftOrExt = "md" end
	if ftOrExt == "vimrc" then ftOrExt = "vim" end
	local icon = deviconsInstalled and devicons.get_icon(name, ftOrExt) or ""
	-- add sourcegraph icon for clarity
	if fn.expand("%"):find("^sg") then icon = "󰓁 " .. icon end

	-- truncate
	local nameNoExt = name:gsub("%.%w+$", "")
	if #nameNoExt > maxLen then name = nameNoExt:sub(1, maxLen) .. "…" .. ext end

	if icon == "" then return name end
	return icon .. " " .. name
end



function M.version_date()
  local version = vim.version()
  local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
  local datetime = os.date("%Y/%m/%d %H:%M:%S")

  return print_version .. " " .. datetime
end

function M.lazy_load (plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

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


return M
