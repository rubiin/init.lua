local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local lualine_styles = require("utils").lualine_styles

-- our picker function: styles
local linepicker = function(opts)
  opts = opts or {}

  local selection_to_style = function(selection)
    local style = lualine_styles(selection["ordinal"])
    require("lualine").setup(style)
  end

  local next_style = function(bfnbr)
    actions.move_selection_next(bfnbr)
    local selection = action_state.get_selected_entry()
    selection_to_style(selection)
  end

  local prev_style = function(bfnbr)
    actions.move_selection_previous(bfnbr)
    local selection = action_state.get_selected_entry()
    selection_to_style(selection)
  end

  pickers
    .new(opts, {
      prompt_title = "Lualine styles",
      finder = finders.new_table({
        results = {
          { "slanted", require("utils").styles.slanted },
          { "bubbly", require("utils").styles.bubbly },
          { "default", require("utils").styles.default },
        },
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
          selection_to_style(selection)
        end)
        map("i", "<C-j>", next_style)
        map("i", "<C-k>", prev_style)

        return true
      end,
    })
    :find()
end

return linepicker
