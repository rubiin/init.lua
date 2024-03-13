local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local state = require("telescope.actions.state")

---@class Change
---@field raw string
---@field change number
---@field line number
---@field col number
---@field text string

-- Parse a line from :changes into a table
---@param item string
---@return Change
local function parse_change(item)
  local change, line, col, text = item:match("([0-9]+)%s+([0-9]+)%s+([0-9]+)%s+(.*)")
  return {
    raw = item,
    change = tonumber(change),
    line = tonumber(line),
    col = tonumber(col),
    text = text,
  }
end

---@param item Change
local entry_maker = function(item)
  return {
    value = item,
    display = item.text,
    ordinal = item.change,
    lnum = item.line,
    col = item.col,
    filename = vim.fn.expand(vim.api.nvim_buf_get_name(0)), -- for previewer
  }
end

local function get_results()
  ---@type Change[]
  local results = {}
  local changes = vim.api.nvim_exec2("changes", { output = true }).output

  for line in changes:gmatch("[^\r\n]+") do
    local change = parse_change(line)
    -- skip unwanted lines (header, last line if it only contains a ">")
    if change.line ~= nil then
      -- insert at the beginning of the table so that the most recent change is at the top
      table.insert(results, 1, change)
    end
  end

  return results
end

local function show_changes(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Changes",
      finder = finders.new_table({
        results = get_results(),
        entry_maker = entry_maker,
      }),
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = state.get_selected_entry()

          ---@type Change
          local change = selection.value

          -- close the picker
          actions.close(prompt_bufnr)

          -- go to the line
          vim.api.nvim_win_set_cursor(0, { change.line, change.col + 1 })
        end)
        return true
      end,
    })
    :find()
end

return require("telescope").register_extension({
  exports = {
    chnagelist = show_changes,
  },
})
