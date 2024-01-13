# 💤 My neo vim config

This was bound to happen.

# init.lua/

<a href="https://dotfyle.com/rubiin/initlua"><img src="https://dotfyle.com/rubiin/initlua/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/rubiin/initlua"><img src="https://dotfyle.com/rubiin/initlua/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/rubiin/initlua"><img src="https://dotfyle.com/rubiin/initlua/badges/plugin-manager?style=flat" /></a>

## Prerequisites:

- Nerd font
- Neovim

## Install Instructions

> Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:rubiin/init.lua ~/.config/rubiin/init.lua
NVIM_APPNAME=rubiin/init.lua/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=rubiin/init.lua/ nvim
```

## UI
### Start screen with dashboard-nvim
![](https://i.imgur.com/DNVB7mz.png)

### Editor
![](https://i.imgur.com/xDAApQb.png)

## Plugins

+ Plugin management via [Lazy.nvim](https://github.com/folke/lazy.nvim).
+ Code, snippet, word auto-completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
+ Language server protocol (LSP) support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
+ Better code folding  with [nvim-ufo](https://github.com/evinhwang91/nvim-ufo).
+ Ultra-fast project-wide fuzzy searching via [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
+ Faster code commenting via [mini-comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md).
+ Faster matching pair insertion and jump via [rainbow-delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim).
+ Fast buffer jump via [flash.nvim](https://github.com/folke/flash.nvim).
+ Powerful snippet insertion via [Luasnip](https://github.com/L3MON4D3/LuaSnip).
+ Beautiful statusline via [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
+ File tree explorer via [neo-tree.lua](https://github.com/nvim-neo-tree/neo-tree.nvim).
+ Show search index and count with [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens).
+ User-defined mapping hint via [which-key.nvim](https://github.com/folke/which-key.nvim).
+ Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
+ Beautiful colorscheme via [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim) and other colorschemes.
+ LaTeX editing and previewing via [vimtex](https://github.com/lervag/vimtex)
+ Animated GUI style notification via [nvim-notify](https://github.com/rcarriga/nvim-notify).
+ Code formatting via [Conform](https://github.com/stevearc/conform.nvim).
+ Undo management via [debugloop/telescope-undo.nvim](https://dotfyle.com/plugins/debugloop/telescope-undo.nvim)

