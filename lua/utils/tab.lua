-- File: lua/minicybu.lua
-- Minimal, polished buffer cycler inspired by ghillb/cybu.nvim

local M = {}

M.config = {
  width = 50,
  height = 5,
  timeout = 700,
  relative = "editor",
  border = "rounded",
  show_neighbors = 2,
  padding = 1,
  persistent = false, -- ⬅️ new: keep window open while cycling
  highlights = {
    focus = "IncSearch",
    neighbor = "Comment",
    border = "FloatBorder",
    background = "NormalFloat",
  },
}

-- get listed buffers with names
-- list all listed buffers like :ls, ensure they are loaded
local function list_buffers()
  local bufs = vim.fn.getbufinfo()
  local list = {}

  for _, b in ipairs(bufs) do
    if b.listed == 1 then
      -- force load if unloaded
      if not vim.api.nvim_buf_is_loaded(b.bufnr) then
        vim.fn.bufload(b.bufnr)
      end

      local name = b.name
      if name == "" then
        name = "[No Name]"
      else
        name = vim.fn.fnamemodify(name, ":~:.")
      end

      table.insert(list, { id = b.bufnr, name = name })
    end
  end

  -- sort by buffer number to match :ls order
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  return list
end
local function current_index(bufs)
  local cur = vim.api.nvim_get_current_buf()
  for i, b in ipairs(bufs) do
    if b.id == cur then
      return i
    end
  end
  return 1
end

-- UTF-8 safe truncate
local function str_display_truncate(s, width)
  local disp = vim.fn.strdisplaywidth(s)
  if disp <= width then
    return s
  end
  while vim.fn.strdisplaywidth(s .. "…") > width do
    s = s:sub(1, vim.fn.strchars(s) - 1)
  end
  return s .. "…"
end

local function build_lines(bufs, idx)
  local cfg = M.config
  local lines = {}
  local from = math.max(1, idx - cfg.show_neighbors)
  local to = math.min(#bufs, idx + cfg.show_neighbors)
  for i = from, to do
    local b = bufs[i]
    local prefix = (i == idx) and "▶ " or "  "
    local line = prefix .. b.name
    line = str_display_truncate(line, cfg.width - cfg.padding * 2)
    line = string.rep(" ", cfg.padding) .. line .. string.rep(" ", cfg.padding)
    table.insert(lines, line)
  end
  return lines, from, to
end

local function open_preview(bufs, idx)
  local cfg = M.config
  local lines, from, to = build_lines(bufs, idx)

  local winbuf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(winbuf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(winbuf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(winbuf, "modifiable", false)
  vim.api.nvim_buf_set_option(winbuf, "filetype", "minicybu")

  local width = cfg.width
  local height = math.min(cfg.height, #lines)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = 2

  local opts = {
    relative = cfg.relative,
    anchor = "NW",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = cfg.border,
  }

  local win = vim.api.nvim_open_win(winbuf, false, opts)

  local line_idx = 0
  for i = from, to do
    local hl = (i == idx) and cfg.highlights.focus or cfg.highlights.neighbor
    pcall(vim.api.nvim_buf_add_highlight, winbuf, -1, hl, line_idx, 0, -1)
    line_idx = line_idx + 1
  end

  vim.api.nvim_win_set_option(win, "wrap", false)
  vim.api.nvim_win_set_option(win, "cursorline", false)
  vim.api.nvim_win_set_option(win, "number", false)
  vim.api.nvim_win_set_option(win, "relativenumber", false)

  pcall(vim.api.nvim_set_hl, 0, "MinicybuBorder", { link = cfg.highlights.border })
  pcall(vim.api.nvim_set_hl, 0, "MinicybuBackground", { link = cfg.highlights.background })

  return { win = win, buf = winbuf }
end

local function close_preview(state)
  if not state or not state.win then
    return
  end
  if vim.api.nvim_win_is_valid(state.win) then
    pcall(vim.api.nvim_win_close, state.win, true)
  end
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    pcall(vim.api.nvim_buf_delete, state.buf, { force = true })
  end
end

local preview_state = nil
local timer = nil

local function schedule_close()
  local to = M.config.timeout
  if timer then
    pcall(vim.loop.kill, timer)
  end
  timer = vim.loop.new_timer()
  timer:start(
    to,
    0,
    vim.schedule_wrap(function()
      close_preview(preview_state)
      preview_state = nil
      if timer then
        timer:stop()
        timer:close()
        timer = nil
      end
    end)
  )
end

local function switch_by(offset)
  local bufs = list_buffers()
  if #bufs == 0 then
    return
  end
  local idx = current_index(bufs)
  idx = ((idx - 1 + offset) % #bufs) + 1
  local target = bufs[idx].id

  if not M.config.persistent then
    close_preview(preview_state)
    preview_state = open_preview(bufs, idx)
    schedule_close()
  else
    if not preview_state or not preview_state.win or not vim.api.nvim_win_is_valid(preview_state.win) then
      preview_state = open_preview(bufs, idx)
    else
      close_preview(preview_state)
      preview_state = open_preview(bufs, idx)
    end
  end

  vim.api.nvim_set_current_buf(target)
end

function M.next()
  switch_by(1)
end

function M.prev()
  switch_by(-1)
end

function M.setup(user_cfg)
  if user_cfg then
    for k, v in pairs(user_cfg) do
      if k ~= "highlights" then
        M.config[k] = v
      end
    end
    if user_cfg.highlights then
      for kk, vv in pairs(user_cfg.highlights) do
        M.config.highlights[kk] = vv
      end
    end
  end
end

vim.api.nvim_create_user_command("MiniCybuNext", function()
  M.next()
end, {})
vim.api.nvim_create_user_command("MiniCybuPrev", function()
  M.prev()
end, {})

return M
