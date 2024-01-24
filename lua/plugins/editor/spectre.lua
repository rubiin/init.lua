--- General configuration for spectre base on current git repo
---@param default_opts table | nil
---@return table
function _G.get_spectre_options(default_opts)
  local util = require('utils.helpers')
  local opts = default_opts or {}

  if util.is_git_repo() then opts.cwd = util.get_git_root() end

  return opts
end

return {
  {
    -- Search and replace with pattern
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    lazy = true,
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      {
        '<leader>sr',
        function() require('spectre').open() end,
        desc = 'Replace in files',
      },
      {
        '<leader>sp',
        function() require('spectre').open(_G.get_spectre_options()) end,
        desc = 'Replace in files (Root dir)',
      },
      -- Search current word
      {
        '<leader>sP',
        function() require('spectre').open_visual(_G.get_spectre_options({ select_word = true })) end,
        desc = 'Replace current word (Root dir)',
      },
      -- Open search with select word in visual mode
      {
        '<leader>sr',
        function() require('spectre').open_visual(_G.get_spectre_options()) end,
        mode = 'v',
        silent = true,
        desc = 'Replace current word (Root dir)',
      },
    },
  },
}
