local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local icons = require("nvim-web-devicons").get_icons()

local resultTable = {}

local function action(icon)
  vim.fn.setreg("*", icon)
  print([[Press p or "*p to paste this icon]] .. icon)
end

-- Iterate over the original table
for key, value in pairs(icons) do
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

      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          action(selection.value[2])
        end)

        return true
      end,
    })
    :find()
end

return require("telescope").register_extension({
  exports = { nerdfont = nerdfont },
})
