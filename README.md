# 💤 My neovim config

Based on LazyVim as a starter, though most stuffs are overridden to keep less dependency on LazyVim as possible. The one based on lunarvim can be found at my dotfiles repo but I wanted more barebones and minimal
as a result of which this repo was born which was sooner or later bound to happen

## init.lua/(Always WIP)

<a href="https://dotfyle.com/rubiin/initlua"><img src="https://dotfyle.com/rubiin/initlua/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/rubiin/initlua"><img src="https://dotfyle.com/rubiin/initlua/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/rubiin/initlua"><img src="https://dotfyle.com/rubiin/initlua/badges/plugin-manager?style=flat" /></a>

## ⚡ Requirements

- Neovim >= **0.9.4** (needs to be built with **LuaJIT**)
- Git >= **2.19.0** (for partial clones support)
- a [Nerd Font](https://www.nerdfonts.com/)(v3.0 or greater) as your terminal font.
  > Make sure the nerd font you set doesn't end with Mono to prevent small icons.
  > Example : `JetbrainsMono Nerd Font` and not ~~JetbrainsMono Nerd Font Mono~~
- [lazygit](https://github.com/jesseduffield/lazygit) **_(optional)_** for git integration
- a **C** compiler for `nvim-treesitter`. See [here](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) **_(optional)_**
  - **live grep**: [ripgrep](https://github.com/BurntSushi/ripgrep)
  - **find files**: [fd](https://github.com/sharkdp/fd)
- a terminal that support true color and _undercurl_:
  - [kitty](https://github.com/kovidgoyal/kitty) **_(Linux & Macos)_**
  - [wezterm](https://github.com/wez/wezterm) **_(Linux, Macos & Windows)_**
  - [alacritty](https://github.com/alacritty/alacritty) **_(Linux, Macos & Windows)_**
  - [iterm2](https://iterm2.com/) **_(Macos)_**

You can also run the `setup.sh` if you are lazy and it will install all the requirements for you considering
you are on a unix based system

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

## Docker Instructions

```sh
docker run -w /root -it --rm alpine:latest sh -uelic '
  apk add git nodejs neovim ripgrep build-base wget --update
  git clone https://github.com/rubiin/init.lua ~/.config/nvim
  nvim
  '
```

- NOTE for Windows users:
- don't use Windows
- try WSL2 on Windows and pretend you're on Linux (it's better)

## Directory structure

```
├── ftplugin                             # Override filetype settings
└── plugin                               # Plugin configurations
├── biome.json                           # Configuration file for a specific feature or plugin
├── cspell.json                          # Configuration file for the cspell spellchecker
├── cspell-tool.txt                      # Custom dictionary for cspell
├── doc
│   └── keymaps.md                       # Documentation file for keymaps
├── init.lua                             # Initialization file for Vim or Neovim
├── lazy-lock.json                       # Configuration file for a specific feature or plugin
├── lazyvim.json                         # Configuration file for a specific feature or plugin
├── LICENSE                              # File containing licensing information
├── lua
│   ├── config                           # Core configuration scripts
│   ├── custom                           # Custom Lua scripts
│   ├── plugins                          # Configurations for plugins
│   │   ├── coding
│   │   ├── disabled.lua
│   │   ├── editor
│   │   ├── extras
│   │   ├── init.lua
│   │   ├── lang
│   │   ├── lsp
│   │   └── ui
│   └── utils                            # Utility scripts
├── misc                                 # Misc folders
│   ├── snippets
│   └── undo
├── README.md                            # Readme file for the project
├── selene.toml                          # Possible configuration file for a tool or plugin
├── setup.sh                             # Shell script for bootstrapping required tools
├── spell                                # Directory possibly containing spellcheck related files
└── stylua.toml                          # Configuration file for Stylua
```

## UI

### Start screen with dashboard-nvim

![dashboard](https://i.imgur.com/AA3ty9F.png)

### Editor

![editor](https://i.imgur.com/xDAApQb.png)

## Plugins

- Plugin management via [Lazy.nvim](https://github.com/folke/lazy.nvim).
- Code, snippet, word auto-completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
- Language server protocol (LSP) support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
- Better escaping from insert mode via [better-escape](https://github.com/nvim-zh/better-escape.vim).
- Better code folding with [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo).
- Ultra-fast project-wide fuzzy searching via [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
- Faster code commenting via [mini-comment](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md).
- Faster matching pair insertion and jump via [rainbow-delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim).
- Fast buffer jump via [flash.nvim](https://github.com/folke/flash.nvim).
- Powerful snippet insertion via [Luasnip](https://github.com/L3MON4D3/LuaSnip).
- Better quickfix list with [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf).
- Beautiful statusline via [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
- File tree explorer via [neo-tree.lua](https://github.com/nvim-neo-tree/neo-tree.nvim).
- User-defined mapping hint via [which-key.nvim](https://github.com/folke/which-key.nvim).
- Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Beautiful colorscheme via [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim) and other colorschemes.
- LaTeX editing and previewing via [vimtex](https://github.com/lervag/vimtex)
- Animated GUI style notification via [nvim-notify](https://github.com/rcarriga/nvim-notify).
- Code formatting via [Conform](https://github.com/stevearc/conform.nvim).
- Asynchronous code execution via [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim).
- Undo management via [debugloop/telescope-undo.nvim](https://dotfyle.com/plugins/debugloop/telescope-undo.nvim)
- Markdown writing and previewing via [vim-markdown](https://github.com/preservim/vim-markdown) and [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).

## Personalization

You can customize the banner with the globals on `lua/rubiin/globals.lua`:

```lua
g.vscode_snippets_path = fn.stdpath("config") .. "/misc/snippets" -- Path to vscode snippets
g.github_username = "rubiin" -- Github username
g.random_banner = true -- Random banner
g.fortune = true -- Fortune in start screen
g.border_style = "single" ---@type "single"|"double"|"rounded"|"solid"|"none"
```

If you want to start neovim with no plugins whatsoever you can use the `--clean` flag. For example, if you want
to use neovim as your git editor you can add this to your `.gitconfig`:

```sh
core.editor = nvim --clean
```

## Credits and Further reading/learning

- Teejay Dev for his [videos](https://www.youtube.com/@teej_dv)
- Christian Chiarulli for his [videos](https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA)
- ThePrimeagen for his [videos](https://www.youtube.com/channel/UC8ENHE5xdFSwx71u3fDH5Xw)
- Alpha2phi for his [Article](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f)
