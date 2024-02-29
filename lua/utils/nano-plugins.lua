-- These are several commands that are too small to be created as standalone plugins,
-- but too large to be included directly in the main configuration file, where they
-- might clutter the actual configuration. Each function is self-contained, apart from
-- the helper functions included here, and should be assigned to a keymap for easy access.

local M = {}
local fn = vim.fn
local utils = require("utils")

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
    vim.notify("Opening URL: " .. matched_url)
    M.open_in_browser(url)
  else
    vim.notify("No URL found under the cursor")
  end
end

return M
