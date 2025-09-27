-- %s Author: Rubin Bhandari <roobin.bhandari@gmail.com>
-- %s Date: 2024-05-23
-- %s GitHub: https://github.com/rubiin
-- %s Twitter: https://twitter.com/RubinCodes
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

local function get_comment_str()
  if vim.bo.commentstring == "" then
    vim.notify("No commentstring for " .. vim.bo.ft, vim.log.levels.WARN, { title = "Comment" })
    return
  end
  return vim.bo.commentstring
end

-- appends a horizontal line, with the language's comment syntax,
-- correctly indented and padded
function M.commentHr()
  local comment_str = get_comment_str()
  if not comment_str then
    return
  end
  local startLn = vim.api.nvim_win_get_cursor(0)[1]

  -- determine indent
  local ln = startLn
  local line, indent
  repeat
    line = vim.api.nvim_buf_get_lines(0, ln - 1, ln, true)[1]
    indent = line:match("^%s*")
    ln = ln - 1
  until line ~= "" or ln == 0

  local indent_length = vim.bo.expandtab and #indent or #indent * vim.bo.tabstop
  local com_str_length = #(comment_str:format(""))
  local text_width = vim.o.textwidth > 0 and vim.o.textwidth or 80
  local hr_length = text_width - (indent_length + com_str_length)

  -- construct hr
  local hr_char = comment_str:find("%-") and "-" or "─"
  local hr = hr_char:rep(hr_length)
  local hr_with_omment = comment_str:format(hr)

  -- filetype-specific padding
  local formatter_want_padding = { "python", "css", "scss" }
  if not vim.tbl_contains(formatter_want_padding, vim.bo.ft) then
    hr_with_omment = hr_with_omment:gsub(" ", hr_char)
  end
  local fullLine = indent .. hr_with_omment

  -- append lines & move
  vim.api.nvim_buf_set_lines(0, startLn, startLn, true, { fullLine, "" })
  vim.api.nvim_win_set_cursor(0, { startLn + 1, #indent })
end

-- HUUUUUUUUUUUUUUUUUUUUUUUGE kudos and thanks to
-- https://github.com/hown3d for this function <3
local function substitute(cmd)
  cmd = cmd:gsub("%%", vim.fn.expand("%"))
  cmd = cmd:gsub("$fileBase", vim.fn.expand("%:r"))
  cmd = cmd:gsub("$filePath", vim.fn.expand("%:p"))
  cmd = cmd:gsub("$file", vim.fn.expand("%"))
  cmd = cmd:gsub("$dir", vim.fn.expand("%:p:h"))
  cmd = cmd:gsub("#", vim.fn.expand("#"))
  cmd = cmd:gsub("$altFile", vim.fn.expand("#"))

  return cmd
end

function M.code_runner()
  local file_extension = vim.fn.expand("%:e")
  local selected_cmd = ""
  local term_cmd = "vsplit term://"
  local supported_filetypes = {
    html = {
      default = "%",
    },
    c = {
      default = "gcc % -o $fileBase && $fileBase",
      debug = "gcc -g % -o $fileBase && $fileBase",
    },
    cs = {
      default = "dotnet run",
    },
    cpp = {
      default = "g++ % -o  $fileBase && $fileBase",
      debug = "g++ -g % -o  $fileBase",
      -- competitive = "g++ -std=c++17 -Wall -DAL -O2 % -o $fileBase && $fileBase<input.txt",
      competitive = "g++ -std=c++17 -Wall -DAL -O2 % -o $fileBase && $fileBase",
    },
    py = {
      default = "python %",
    },
    go = {
      default = "go run %",
    },
    java = {
      default = "java %",
    },
    js = {
      default = "node %",
      debug = "node --inspect %",
    },
    ts = {
      default = "tsc % && node $fileBase",
    },
    rs = {
      default = "rustc % && $fileBase",
    },
    php = {
      default = "php %",
    },
    r = {
      default = "Rscript %",
    },
    jl = {
      default = "julia %",
    },
    rb = {
      default = "ruby %",
    },
    pl = {
      default = "perl %",
    },
  }

  if supported_filetypes[file_extension] then
    local choices = vim.tbl_keys(supported_filetypes[file_extension])

    if #choices == 0 then
      vim.notify("It doesn't contain any command", vim.log.levels.WARN, { title = "Code Runner" })
    elseif #choices == 1 then
      selected_cmd = supported_filetypes[file_extension][choices[1]]
      vim.cmd(term_cmd .. substitute(selected_cmd))
    else
      vim.ui.select(choices, { prompt = "Choose a command: " }, function(choice)
        selected_cmd = supported_filetypes[file_extension][choice]
        if selected_cmd then
          vim.cmd(term_cmd .. substitute(selected_cmd))
        end
      end)
    end
  else
    vim.notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = "Code Runner" })
  end
end

--> Run the current file according to filetype
---@param ht? number for height or "v" for vertical
M.run_file = function(ht)
  local fts = {
    rust = "cargo run",
    python = "python %",
    javascript = "npm start",
    c = "make",
    cpp = "make",
    java = "java %",
  }

  local cmd = fts[vim.bo.ft]
  vim.cmd(cmd and ("w | " .. (ht or "") .. "sp | term " .. cmd) or "echo 'No command for this filetype'")
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

  local comment = get_comment_str() or ""

  -- replace %s in comment string with empty
  comment = string.format(comment, "")

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
