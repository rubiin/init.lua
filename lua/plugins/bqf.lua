return{
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    event = "VeryLazy",
    config = function()
      require("bqf").setup {
        auto_resize_height = false,
        preview = {
          auto_preview = false,
        }
      }
    end
  }
}
