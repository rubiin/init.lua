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

--TODO: add code to restore as well
-- mini misc zoom function
---@param buf_id? number
---@param config? any
function M.zoom(buf_id, config)
  local H = {}
  if H.zoom_winid and vim.api.nvim_win_is_valid(H.zoom_winid) then
    vim.api.nvim_win_close(H.zoom_winid, true)
    H.zoom_winid = nil
  else
    buf_id = buf_id or vim.api.nvim_get_current_buf()
    -- Currently very big `width` and `height` get truncated to maximum allowed
    local default_config = { relative = "editor", row = 0, col = 0, width = 1000, height = 1000 }
    config = vim.tbl_deep_extend("force", default_config, config or {})
    H.zoom_winid = vim.api.nvim_open_win(buf_id, true, config)
    vim.wo.winblend = 0
    vim.cmd("normal! zz")
  end
end

-- Opens the given url in the default browser.
---@param url string: The url to open.
function M.open_in_browser(url)
  local executables = { "xdg-open", "explorer", "open", "wslview" }
  local open_cmd = ""

  for _, value in ipairs(executables) do
    if fn.executable(value) == 1 then
      open_cmd = value
      break
    end
  end

  if open_cmd == "" then
    M.notify("No browser found to open the URL", vim.log.levels.ERROR, "Utils")
    return
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

  local supported_filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "python",
  }

  if not utils.list_contains(supported_filetypes, lang) then
    M.notify("Unsupported filetype.", vim.log.levels.ERROR, "Utils")
  end

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

-- Adds author details to files
function M.add_author_details()
  -- Define author details
  local author = {
    name = "Rubin Bhandari",
    email = "roobin.bhandari@gmail.com",
    github = "rubiin",
    twitter = "RubinCodes",
  }

  -- Get current buffer's file type
  local filetype = vim.bo.filetype

  local double_slash_based = {
    "c",
    "go",
    "css",
    "php",
    "java",
    "rust",
    "sass",
    "scala",
    "dart",
    "swift",
    "kotlin",
    "javascript",
    "typescript",
    "cpp",
    "javascriptreact",
    "typescriptreact",
  }

  local hash_based = {
    "r",
    "sh",
    "perl",
    "bash",
    "ruby",
    "zsh",
    "python",
  }

  local comment_syntax = {}

  for _, value in ipairs(hash_based) do
    comment_syntax[value] = "# "
  end

  for _, value in ipairs(double_slash_based) do
    comment_syntax[value] = "// "
  end

  comment_syntax["lua"] = "-- "

  -- Get the comment syntax for the current file type
  local comment = comment_syntax[filetype]

  -- If comment syntax not found, use default
  if not comment then
    vim.notify("💁 Woops, file format not supported for now")
    return
  end

  -- Format the comment with author details
  -- Get current buffer
  local comment_details = string.format(
    "%s Author: %s <%s>\n%s Date: %s\n%s GitHub: https://github.com/%s\n%s Twitter: https://twitter.com/%s\n",
    comment,
    author.name,
    author.email,
    comment,
    os.date("%Y-%m-%d"), -- Add the date here using os.date() function with appropriate format
    comment,
    author.github,
    comment,
    author.twitter
  )

  local bufnr = vim.api.nvim_get_current_buf()
  -- Get existing buffer lines
  local existing_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Split the replacement string into lines
  local replacement_lines = {}
  for line in comment_details:gmatch("[^\r\n]+") do
    table.insert(replacement_lines, line)
  end

  -- Insert the new lines at the beginning of the buffer
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, replacement_lines)

  -- Append the existing lines after the new lines
  vim.api.nvim_buf_set_lines(bufnr, #replacement_lines, -1, false, existing_lines)

  vim.notify("✅ Added author details")
end

return M
