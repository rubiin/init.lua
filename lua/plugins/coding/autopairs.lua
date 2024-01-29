return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      map_cr = true,
      map_bs = true, -- map the <BS> key
      map_c_h = false, -- Map the <C-h> key to delete a pair
      map_c_w = false, -- map <c-w> to delete a pair if possible
      disable_in_visualblock = true,
      check_ts = true,
    },
  },
}
