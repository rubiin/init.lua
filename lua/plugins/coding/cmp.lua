local luasnip = require('luasnip')

return {
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        luasnip.filetype_extend('typescript', { 'tsdoc' })
        luasnip.filetype_extend('javascript', { 'jsdoc' })
        luasnip.filetype_extend('lua', { 'luadoc' })
        luasnip.filetype_extend('python', { 'pydoc' })
        luasnip.filetype_extend('rust', { 'rustdoc' })
        luasnip.filetype_extend('sh', { 'shelldoc' })
        require('luasnip.loaders.from_vscode').load({
          include = {
            'javascript',
            'css',
            'docker',
            'go',
            'html',
            'javascript',
            'json',
            'lua',
            'markdown',
            'python',
            'rust',
            'shell',
            'sql',
          },
        })
        require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/misc/snippets' } })
      end,
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-emoji',
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      local cmp = require('cmp')
      table.insert(opts.sources, { name = 'emoji' })
      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm({ select = true })
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })
    end,
  },
}
