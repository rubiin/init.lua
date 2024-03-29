local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local set_lualine_styles = require("utils").set_lualine_styles
local lualine_styles = require("utils.constants").styles

-- our picker function: styles
local lualine = function(opts)
  opts = opts or {}

  local selection_to_style = function(selection)
    local style = set_lualine_styles(selection["ordinal"])
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
          { "slanted", lualine_styles.slanted },
          { "bubbly", lualine_styles.bubbly },
          { "default", lualine_styles.default },
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

return require("telescope").register_extension({
  exports = { lualine = lualine },
})
