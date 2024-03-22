local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local icons = require("nvim-web-devicons").get_icons()

local resultTable = {}

-- Iterate over the original table
for _, value in pairs(icons) do
  -- Check if the value is a table (ignoring the first entry which is also a table)
  if type(value) == "table" then
    -- Insert {icon, name} into the result table
    table.insert(resultTable, { value.name .. " " .. value.icon, value.icon })
  end
end

-- our picker function: icons
local nerdfont = function(opts)
  opts = opts or {}

  pickers
    .new(opts, {
      prompt_title = "Icon picker",
      finder = finders.new_table({
        results = resultTable,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local icon = selection.value[2]

          local cursor_position = vim.api.nvim_win_get_cursor(0)
          local row = cursor_position[1]
          local column = cursor_position[2]
          -- insert icon after cursor
          vim.api.nvim_buf_set_text(0, row - 1, column, row - 1, column, { icon })
          -- move cursor to the end of the inserted icon
          vim.api.nvim_win_set_cursor(0, { row, column + #icon })
        end)

        return true
      end,
    })
    :find()
end

return require("telescope").register_extension({
  exports = { nerdfont = nerdfont },
})
