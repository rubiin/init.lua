return {

  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", {
      "Kaiser-Yang/blink-cmp-git",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = { "nvim-lua/plenary.nvim" },
      }, },
    -- use a release tag to download pre-built binaries
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- https://cmp.saghen.dev/configuration/keymap.html
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
        ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
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
        default = { "lsp", "buffer", "snippets", "path", "git", "dictionary" },
        providers = {
          git = {
            module = "blink-cmp-git",
            name = "Git",
            opts = {},
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            max_items = 10,
            opts = {
              dictionary_files = { vim.fn.expand("~/.config/dictionaries/words.txt") },
            },
          },
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
