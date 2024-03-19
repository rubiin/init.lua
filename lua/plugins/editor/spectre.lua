--- General configuration for spectre base on current git repo
---@param default_opts table?
---@return table
function _G.get_spectre_options(default_opts)
  local utils = require("utils")
  local opts = default_opts or {}

  if utils.is_git_repo() then
    opts.cwd = utils.get_git_root()
  end

  return opts
end

-- Search and replace with pattern
return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    event = "LazyFile",
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace In Files",
      },
      {
        "<leader>sf",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Replace In Current File",
      },
      {
        "<leader>sP",
        function()
          require("spectre").open_visual(_G.get_spectre_options({ select_word = true }))
        end,
        desc = "Replace Current Word (Root dir)",
      },
      -- Open search with select word in visual mode
      {
        "<leader>sr",
        function()
          require("spectre").open_visual(_G.get_spectre_options())
        end,
        mode = "v",
        silent = true,
        desc = "Replace Current Word (Root dir)",
      },
    },
    config = function()
      -- for vscode like search highlight, use bg=#323c1c and bg=#461313 respectively
      vim.api.nvim_set_hl(0, "SpectreChange", { bg = "#99cf95", fg = "black" })
      vim.api.nvim_set_hl(0, "SpectreReplace", { bg = "#f38ba8", fg = "black" })
      require("spectre").setup({
        is_insert_mode = true, -- start open panel on is_insert_mode
        is_block_ui_break = true, -- prevent the UI from breaking
        highlight = {
          search = "SpectreChange",
          replace = "SpectreReplace",
        },
      })
    end,
  },
}
