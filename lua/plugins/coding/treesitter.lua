return {
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufNewFile", "BufReadPre" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      aliases = {
        ["vue"] = "html",
      },
    },
  },
}
