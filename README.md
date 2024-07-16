# 💤 My neovim config aka PDE (Personal Development Environment)

Behold, the mystical incantations of my Neovim configuration, carefully crafted to summon the spirits of efficiency and productivity from the depths of the digital abyss. With the precision of a surgeon and the finesse of a ninja, I've concocted a brew of plugins and keybindings that dance harmoniously to the rhythm of my keystrokes weaving spells of autocomplete and syntax highlighting to illuminate the darkest recesses of my codebase.

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

## Post installation

Replace local plugins specs with the ones from the remote repository:
`~/personal-vim-plugs/xyz` becomes `rubiin/xyz`

NOTE for Windows users:

- don't use Windows
- try WSL2 on Windows and pretend you're on Linux (it's better)

## Directory structure

```
├── after
│   └── ftplugin                         # Override filetype settings
│   └── queries                         # Override filetype settings
├── autoload
├── biome.json                           # Configuration file for a specific feature or plugin
├── init.lua                             # Initialization file for Vim or Neovim
├── lazy-lock.json                       # Configuration file for a specific feature or plugin
├── lazyvim.json                         # Configuration file for a specific feature or plugin
├── LICENSE                              # File containing licensing information
├── lua
│   ├── config                           # Core configuration scripts
│   ├── custom                           # Custom Lua scripts
│   ├── plugins                          # Configurations for plugins
│   │   ├── coding                       # Coding related plugins
│   │   ├── disabled.lua                 # Disabled plugins
│   │   ├── editor                       # Editor related plugins
│   │   ├── extras                       # Extra plugins that are not loaded by default
│   │   ├── init.lua
│   │   ├── lsp                          # Language server protocol related plugins
│   │   └── ui                           # UI related plugins
│   └── utils                            # Utility scripts
│   └── telescope                        # Custom telescope extension
├── misc                                 # Misc folders
│   ├── snippets
│   └── undo
├── README.md                            # Readme file for the project
├── setup.sh                             # Shell script for bootstrapping required tools
├── spell                                # Directory possibly containing spellcheck related files
└── stylua.toml                          # Configuration file for Stylua
```

## UI

### Start screen with dashboard-nvim

![dashboard](https://i.imgur.com/AA3ty9F.png)

### Editor

![editor](https://i.imgur.com/MilOlre.png)

## Plugins

### bars-and-lines

- [Bekaboo/dropbar.nvim](https://dotfyle.com/plugins/Bekaboo/dropbar.nvim)

### code-runner

- [hkupty/iron.nvim](https://dotfyle.com/plugins/hkupty/iron.nvim)

### color

- [folke/twilight.nvim](https://dotfyle.com/plugins/folke/twilight.nvim)

### colorscheme

- [folke/tokyolight.nvim](https://dotfyle.com/plugins/folke/tokyolight.nvim)

### comment

- [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
- [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
- [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)

### completion

- [zbirenbaum/copilot.lua](https://dotfyle.com/plugins/zbirenbaum/copilot.lua)
- [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)

### cursorline

- [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)

### debugging

- [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)

### editing-support

- [folke/zen-mode.nvim](https://dotfyle.com/plugins/folke/zen-mode.nvim)
- [jiaoshijie/undotree](https://dotfyle.com/plugins/jiaoshijie/undotree)
- [Wansmer/treesj](https://dotfyle.com/plugins/Wansmer/treesj)
- [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
- [HiPhish/rainbow-delimiters.nvim](https://dotfyle.com/plugins/HiPhish/rainbow-delimiters.nvim)
- [okuuva/auto-save.nvim](https://dotfyle.com/plugins/okuuva/auto-save.nvim)

### file-explorer

- [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
- [nvim-neo-tree/neo-tree.nvim](https://dotfyle.com/plugins/nvim-neo-tree/neo-tree.nvim)

### formatting

- [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)

### fuzzy-finder

- [ibhagwan/fzf-lua](https://dotfyle.com/plugins/ibhagwan/fzf-lua)

### game

- [ThePrimeagen/vim-be-good](https://dotfyle.com/plugins/ThePrimeagen/vim-be-good)

### git

- [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
- [akinsho/git-conflict.nvim](https://dotfyle.com/plugins/akinsho/git-conflict.nvim)
- [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)

### icon

- [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)

### indent

- [shellRaining/hlchunk.nvim](https://dotfyle.com/plugins/shellRaining/hlchunk.nvim)
- [echasnovski/mini.indentscope](https://dotfyle.com/plugins/echasnovski/mini.indentscope)

### keybinding

- [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)

### lsp

- [aznhe21/actions-preview.nvim](https://dotfyle.com/plugins/aznhe21/actions-preview.nvim)
- [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
- [smjonas/inc-rename.nvim](https://dotfyle.com/plugins/smjonas/inc-rename.nvim)
- [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
- [marilari88/twoslash-queries.nvim](https://dotfyle.com/plugins/marilari88/twoslash-queries.nvim)

### lsp-installer

- [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)

### markdown-and-latex

- [iamcco/markdown-preview.nvim](https://dotfyle.com/plugins/iamcco/markdown-preview.nvim)
- [MeanderingProgrammer/markdown.nvim](https://dotfyle.com/plugins/MeanderingProgrammer/markdown.nvim)

### marks

- [ThePrimeagen/harpoon](https://dotfyle.com/plugins/ThePrimeagen/harpoon)

### note-taking

- [epwalsh/obsidian.nvim](https://dotfyle.com/plugins/epwalsh/obsidian.nvim)

### nvim-dev

- [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
- [kkharji/sqlite.lua](https://dotfyle.com/plugins/kkharji/sqlite.lua)
- [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)

### plugin-manager

- [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)

### preconfigured

- [LazyVim/LazyVim](https://dotfyle.com/plugins/LazyVim/LazyVim)

### programming-languages-support

- [dmmulroy/ts-error-translator.nvim](https://dotfyle.com/plugins/dmmulroy/ts-error-translator.nvim)

### project

- [ahmedkhalf/project.nvim](https://dotfyle.com/plugins/ahmedkhalf/project.nvim)


### scrolling

- [karb94/neoscroll.nvim](https://dotfyle.com/plugins/karb94/neoscroll.nvim)

### search

- [nvim-pack/nvim-spectre](https://dotfyle.com/plugins/nvim-pack/nvim-spectre)

### session

- [olimorris/persisted.nvim](https://dotfyle.com/plugins/olimorris/persisted.nvim)

### snippet

- [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
- [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)

### startup

- [nvimdev/dashboard-nvim](https://dotfyle.com/plugins/nvimdev/dashboard-nvim)

### statusline

- [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)

### syntax

- [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)

### tabline

- [akinsho/bufferline.nvim](https://dotfyle.com/plugins/akinsho/bufferline.nvim)

### utility

- [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
- [echasnovski/mini.animate](https://dotfyle.com/plugins/echasnovski/mini.animate)
- [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
- [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
- [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)
- [chrisgrieser/nvim-early-retirement](https://dotfyle.com/plugins/chrisgrieser/nvim-early-retirement)
- [ghillb/cybu.nvim](https://dotfyle.com/plugins/ghillb/cybu.nvim)

### workflow

- [m4xshen/hardtime.nvim](https://dotfyle.com/plugins/m4xshen/hardtime.nvim)

## Language Servers

- astro
- eslint
- flow
- graphql
- html
- svelte
- taplo
- vtsls

-Note: These are the plugin list and most of them are not loaded by default.
You can enable them by adding the require line on `lua/plugins/init.lua`.
Some are disabled by default because they are not used by me but I keep them there for reference.

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

But beware, dear traveler, for navigating the labyrinthine corridors of the Neovim config is not for the faint of heart. One wrong keystroke, and you could find yourself lost in a sea of syntax errors, tangled in the vines of conflicting plugins, or worse – staring into the abyss of an unresponsive editor.

Yet fear not, for even in the darkest depths of plugin hell, there is hope. With the wisdom of the Vim masters as your guide and the camaraderie of fellow developers as your shield, you shall emerge victorious. And when you do, you'll look back on your Neovim configuration not just as a set of preferences, but as a testament to your resilience, your creativity, and your ability to laugh in the face of even the most cryptic Vimscript errors.

## Self-Promotion

Like the config? Follow the repository on GitHub.  If you find this config useful, you might also be interested in my other projects:

- [fortune.nvim](https://github.com/rubiin/fortune.nvim)
- [highlighturl.nvim](https://github.com/rubiin/highlighturl.nvim)
- [vimwordlist.nvim](https://github.com/rubiin/vimwordlist.nvim)

## Credits and Further reading/learning

Huge shoutout to the Vim elders, whose ancient wisdom and cryptic commands paved the way for the adoption of Neovim. May your modal editing skills be forever sharp, and your init.lua files forever tidy.

- Teejay Devries for his [videos](https://www.youtube.com/@teej_dv)
- Christian Chiarulli for his [videos](https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA)
- ThePrimeagen for his [videos](https://www.youtube.com/channel/UC8ENHE5xdFSwx71u3fDH5Xw)
- Alpha2phi for his [Article](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f)

May these resources serve as beacons of light on your journey through the labyrinthine corridors of Neovim. Happy coding, and may your keystrokes be ever swift and your plugins ever reliable!
