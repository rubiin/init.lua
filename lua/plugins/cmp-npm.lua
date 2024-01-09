
return {
  {
    "David-Kunz/cmp-npm",
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = "json",
    config = function()
      require('cmp-npm').setup({})
    end
  }
}
