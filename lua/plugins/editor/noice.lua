local all_routes = {
  -- FIX lsp signature bug
  { filter = { event = "msg_show", find = "lsp_signature? handler RPC" }, skip = true },
  -- redirect to popup when message is long
  { filter = { min_height = 10 }, view = "popup" },
  -- code actions
  { filter = { event = "notify", find = "No code actions available" }, view = "mini" },
  { filter = { event = "notify", find = ":!setxkbmap -option ctrl:nocaps" }, view = "mini" },

  {
    filter = {
      event = "msg_show",
      any = {
        { find = "%d+L, %d+B" },
        { find = "; after #%d+" },
        { find = "; before #%d+" },
      },
    },
    view = "mini",
  },
}

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = all_routes,
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
}
