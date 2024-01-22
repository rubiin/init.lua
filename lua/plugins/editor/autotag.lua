return {
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    config = function()
      require('nvim-ts-autotag').setup({
        enable = true,
        enable_rename = true,
        filetypes = {
          'astro',
          'ejs',
          'eta',
          'glimmer',
          'handlebars',
          'hbs',
          'htm',
          'html',
          'javascript',
          'javascriptreact',
          'jsx',
          'markdown',
          'php',
          'rescript',
          'svelte',
          'tsx',
          'typescript',
          'typescriptreact',
          'vue',
          'xml',
        },
      })
    end,
  },
}
