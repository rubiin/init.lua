-- 0.10 , can use native snippets
return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip").filetype_extend("typescript", { "tsdoc" })
        require("luasnip").filetype_extend("javascript", { "jsdoc" })
        require("luasnip").filetype_extend("lua", { "luadoc" })
        require("luasnip").filetype_extend("python", { "pydoc" })
        require("luasnip").filetype_extend("rust", { "rustdoc" })
        require("luasnip").filetype_extend("sh", { "shelldoc" })
        require("luasnip.loaders.from_vscode").lazy_load({
          include = {
            "javascript",
            "css",
            "docker",
            "go",
            "html",
            "typescript",
            "json",
            "lua",
            "markdown",
            "python",
            "rust",
            "shell",
            "sql",
          },
        })
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.vscode_snippets_path or "" } })
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" , "hrsh7th/cmp-nvim-lsp-signature-help" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
    end,
  }


}
