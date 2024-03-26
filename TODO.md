
- `yaml-ls` perhaps now supports formatting without needing to enable it in
  `lspconfig`
- `vim.lsp.get_clients` -> `vim.lsp.get_active_clients`
- lua ft: b.comments
- `vim.system` -> `vim.fn.system`
- `vim.uv` -> `vim.loop`
- ftAbbr & abbreviations.lua: `vim.keymap.set('ia', lhs, rhs, { buffer = true })`
- inlay hints setup: <https://www.reddit.com/r/neovim/comments/16tmzkh/comment/k2gpy16/?context=3>
- change lsp-signature to inlay hint
- `vim.snippet`
  + <https://www.reddit.com/r/neovim/comments/17cwptz/comment/k5uoswd/?context=3>
  + <https://github.com/garymjr/nvim-snippets>
- check if `lua.vim` ftplugin includes `:---` as comment:
  <https://github.com/neovim/neovim/blob/master/runtime/ftplugin/lua.vim#L18>
- `vim.fn.getregion()`
- load `symbol-usage.nvim` and `ray-x/lsp_signature.nvim` only on `LspAttach`
- checkout whether `lsp_workspace_symbols` now finally works in lua
- move from barbecue to dropbar
- o.smoothscroll = true
-   o.foldmethod = "expr"
  o.foldexpr = 'v:lua.require"lazyvim.util".ui.foldexpr()'

Fix this: https://i.imgur.com/gyqU1aL.png
