return {

  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- https://cmp.saghen.dev/configuration/keymap.html
        preset = "none",
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        ["<D-c>"] = { "show", "hide" },
        ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
        ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
        ["<D-g>"] = { "show_signature", "hide_signature" },
      },
      completion = {
        documentation = { window = { border = vim.g.border_style } },
        menu = {
          border = vim.g.border_style,
          draw = {
            columns = { { "kind_icon", "label", gap = 2 }, { "label_description", "kind" } },
          },
        },
      },
      sources = {
        providers = {
          snippets = {
            opts = {
              search_paths = { vim.g.vscode_snippets_path },
            },
          },
        },
      },
    },
  },
}
-- TODO: check the hover doc issue
