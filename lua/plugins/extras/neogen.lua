return {
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Documentation",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
}
