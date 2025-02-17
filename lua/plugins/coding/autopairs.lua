return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- import nvim-autopairs
      local autopairs = prequire("nvim-autopairs")

      -- configure autopairs
      autopairs.setup({
        check_ts = true, -- enable treesitter
        ts_config = {
          lua = { "string", "source" }, -- it will not add a pair on that treesitter node
          javascript = { "string", "template_string" }, -- it will not add a pair on that treesitter node
          java = false, -- it will not add a pair on that treesitter node
        },
        enable_check_bracket_line = false,
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        disable_in_macro = false,
        enable_afterquote = true,
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
        map_cr = true, -- map the <CR> key
        map_bs = true, -- map the <BS> key
        map_c_h = false, -- Map the <C-h> key to delete a pair
        map_c_w = false, -- map <c-w> to delete a pair if possible
        disable_in_visualblock = true,
      })
    end,
  },
}
