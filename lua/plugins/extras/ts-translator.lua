return {
  {
    "dmmulroy/ts-error-translator.nvim",
    event = "LspAttach",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue", "svelte" },
    lazy = true,
    opts = {
      auto_override_publish_diagnostics = true,
    },
  },
}
