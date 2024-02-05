return {
  "tris203/hawtkeys.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = {},
  cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
  init = function()
    -- Disable cmp in hawtkeys buffer
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
      group = vim.api.nvim_create_augroup("hawtkeys-cmp", {}),
      callback = function(args)
        if args.buf == require("hawtkeys.ui").SearchBuf then
          require("cmp").setup.buffer({ enabled = false })
        end
      end,
    })
  end,
}
