-- These are several commands that are too small to be created as standalone plugins,
-- but too large to be included directly in the main configuration file, where they
-- might clutter the actual configuration. Each function is self-contained, apart from
-- the helper functions included here, and should be assigned to a keymap for easy access.

local M = {}
local fn, cmd = vim.fn, vim.cmd
local utils = require("utils")

---@param cmd string
local function normal(cmd)
  vim.cmd.normal({ cmd, bang = true })
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
    M.notify(
      string.format("Failed to open '%s'\nwith command: '%s' (ret: '%d')", url, open_cmd, ret),
      vim.log.levels.ERROR,
      "Utils"
    )
  end
end

-- Open URL under cursor, supports the following formats:
-- - http://google.com
-- - https://google.com
-- - https://www.google.com
-- - http://www.google.com
function M.open_url()
  -- Get the text under the cursor
  local url = fn.expand("<cWORD>")
  -- Check if it resembles a URL
  local matched_url = url:match("^https?://[%w_-]+%.%w+")

  if matched_url then
    vim.notify("🌐 Opening URL: " .. matched_url)
    M.open_in_browser(matched_url)
  else
    vim.notify("💁 Woops, no URL found under the cursor")
  end
end

--- Open the next regex at https://regex101.com/
function M.open_at_regex_101()
  local lang = vim.bo.filetype
  local text, pattern, replace, flags

  if utils.list_contains({ "javascript", "javascriptreact", "typescript", "typescriptreact" }, lang) then
    cmd.TSTextobjectSelect("@regex.outer")
    normal('"zy')
    cmd.TSTextobjectSelect("@regex.inner") -- reselect for easier pasting
    text = vim.fn.getreg("z")
    pattern = text:match("/(.*)/")
    flags = text:match("/.*/(%l*)") or "gm"
    replace = vim.api.nvim_get_current_line():match('replace ?%(/.*/.*, ?"(.-)"')
  elseif lang == "python" then
    normal('"zyi"vi"') -- yank & reselect inside quotes
    pattern = fn.getreg("z")
    local flagInLine = vim.api.nvim_get_current_line():match("re%.([MIDSUA])")
    flags = flagInLine and "g" .. flagInLine:gsub("D", "S"):lower() or "g"
  else
    M.notify("Unsupported filetype.", vim.log.levels.ERROR, "Utils")
    return
  end

  -- `+` is the only character regex101 does not escape on its own. But for it
  -- to work, `\` needs to be escaped as well (SIC)
  pattern = pattern:gsub("%+", "%%2B"):gsub("\\", "%%5C")

  -- DOCS https://github.com/firasdib/Regex101/wiki/FAQ#how-to-prefill-the-fields-on-the-interface-via-url
  local url = ("https://regex101.com/?regex=%s&flags=%s&flavor=%s%s"):format(
    pattern,
    flags,
    lang,
    (replace and "&subst=" .. replace or "")
  )
  M.open_in_browser(url)
end

return M
