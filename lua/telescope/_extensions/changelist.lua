local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function prepare_output_table()
  local lines = {}
  local changes = vim.api.nvim_command_output("changes")

  for change in changes:gmatch("[^\r\n]+") do
      table.insert(lines, change)
  end
  return lines
end

local function show_changes(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Changes",
    finder = finders.new_table {
      results = prepare_output_table()
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

return require("telescope").register_extension({
  exports = { changelist = show_changes },
})
