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
    utils.notify(
      string.format("Failed to open '%s'\nwith command: '%s' (ret: '%d')", url, open_cmd, ret),
      vim.log.levels.ERROR,
      "Utils"
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
    M.notify("No URL found under cursor or the URL is not supported", vim.log.levels.ERROR, "utils")
  end
end

return M
