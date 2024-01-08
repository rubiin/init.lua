local M = {}


function M.disable_plugins(list)
  local disabled_plugins = {}
  for _, plugin in ipairs(list) do
      table.insert(disabled_plugins, {
          plugin,
          enabled = false,
      })
  end
  return disabled_plugins
end





return M
