
return {
  {
    "David-Kunz/cmp-npm",
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = "json",
    config = function()
      require('cmp-npm').setup({})
    end
  }
}
