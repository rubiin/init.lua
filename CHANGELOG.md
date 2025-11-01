## [2.3.0](https://github.com/rubiin/init.lua/compare/v2.1.0...v2.3.0) (2024-05-30)

### Features

- native snippets ([18e94b1](https://github.com/rubiin/init.lua/commit/18e94b1082f28f6e40b61ec727a3cf284a29413a))
- new keymaps and others ([e81bb97](https://github.com/rubiin/init.lua/commit/e81bb97d0f60cbfa5bca2fb48e2c2d275e223f3f))

### Bug Fixes

- comment.nvim remove deprecated options ([de41373](https://github.com/rubiin/init.lua/commit/de41373739f3da087a9ec98e400c68be25248866))
- **copilot:** remove duplicate cmp ([3e1b1c1](https://github.com/rubiin/init.lua/commit/3e1b1c1209f0a500721d29adf6ece6a1ea229ad3))
- dashboard fixes ([24dac49](https://github.com/rubiin/init.lua/commit/24dac49df32ccebfcb3b4a1c38df20ff02da4129))
- lazy load cmp-cmdline ([9dd751f](https://github.com/rubiin/init.lua/commit/9dd751f4b30090b1fcd1829af3a989ced9304180))
- mini surround duplicate import ([91a4865](https://github.com/rubiin/init.lua/commit/91a4865e9ff03caf19091e21606408dc113d6427))
- remove custom zoom as lazy has this baked in ([45f239e](https://github.com/rubiin/init.lua/commit/45f239e420e1bb7abb0d3a589493d5420907448e))
- remove dependencies where not needed ([27c0db0](https://github.com/rubiin/init.lua/commit/27c0db01965fbc43b4c828d926f70c4b834ee44b))
- terminal keymaps ([7208dd0](https://github.com/rubiin/init.lua/commit/7208dd01da01bd7143a47d2853627d357cd7f17f))
- vtls ([2abe562](https://github.com/rubiin/init.lua/commit/2abe562fb02b4e9c1dd067c7cb79a55c8ee0d78e))

---

This PR was generated with [Release Please](https://github.com/googleapis/release-please). See [documentation](https://github.com/googleapis/release-please#release-please).

### Performance Improvements

- **persisted:** lazyload persisted ([1ec52b1](https://github.com/rubiin/init.lua/commit/1ec52b1495b0f83e048721fa710f50e21aca90d6))

### Miscellaneous Chores

- release 2.1.1 ([35e99ce](https://github.com/rubiin/init.lua/commit/35e99cead064ab8c6efd5a87b0f4ad6ebdd4aaa6))
- release 2.3.0 ([9a0a0be](https://github.com/rubiin/init.lua/commit/9a0a0bea718152df97c322c0a7e39260cb0eac7d))

## [2.9.0](https://github.com/rubiin/init.lua/compare/v2.8.0...v2.9.0) (2025-11-01)


### 🚀 New Features

* add LSP lightbulb sign to show available code actions on CursorHold/CursorHoldI ([4fd48f6](https://github.com/rubiin/init.lua/commit/4fd48f621d3bf2c703e0e015b490ac86d6185d7a))
* **snacks:** add bigfile setup to optimize handling of large files ([eb3f664](https://github.com/rubiin/init.lua/commit/eb3f6649e5d6891a7bb6e4e9eaf2d93ae7a8ee48))
* **utils:** add is_file_big (with cache) and blacklist large files for rainbow-delimiters ([919544f](https://github.com/rubiin/init.lua/commit/919544fd5f91001c6d6eefaf4b465f49b98ae3cb))


### 🐛 Bug Fixes

* **snacks:** use Snacks.util.wo in bigfile setup ([535961e](https://github.com/rubiin/init.lua/commit/535961ee01aac654a317ffa09c63ab07a192bf3e))


### 🎨 Code Style

* fix spacing in lua/config/autocmds.lua ([919544f](https://github.com/rubiin/init.lua/commit/919544fd5f91001c6d6eefaf4b465f49b98ae3cb))


### ⚙️ Chores

* add 'service' extension filetype mapping -&gt; systemd ([4794fe7](https://github.com/rubiin/init.lua/commit/4794fe7dc1b4e66e56280b3e55fb061cc7b5ff28))
* add 'tmux' extension mapping to filetype detection ([f3dcc41](https://github.com/rubiin/init.lua/commit/f3dcc413cd4c8dfb043d5381709f1c7d3234af7a))
* add ftplugins for just & toml, update lazy-lock pins, normalize filetype mappings ([2b70a50](https://github.com/rubiin/init.lua/commit/2b70a505af628972573b79dc330ff960b56644f3))
* add harper_ls grammar LSP settings and update lazy-lock pins (nvim-treesitter, snacks.nvim) ([0674b78](https://github.com/rubiin/init.lua/commit/0674b788164fa2948b398512fc35a6aacee4e86e))
* add harper_ls Neovim integration doc link to grammar config ([c727745](https://github.com/rubiin/init.lua/commit/c727745cfc36fa8aa33cd291759eedfcc21105d1))
* add local `bo` alias and use it for buffer options in autocmds.lua ([1518ce1](https://github.com/rubiin/init.lua/commit/1518ce1bc31c9a0e18bda37183c13bca9473b3d5))
* add local `opt` alias and use local aliases for vim.api/vim.fn/vim.cmd/vim.opt in autocmds.lua ([bb7092e](https://github.com/rubiin/init.lua/commit/bb7092e5e440a668f281b3c4f88f5670a7a44feb))
* add screenkey.nvim plugin config and refresh lazy-lock.json ([92dc3fd](https://github.com/rubiin/init.lua/commit/92dc3fd3f8f7bbe36c19a7da0823bfc833e190ec))
* comment out harper_ls LSP settings in grammer.lua ([012cc90](https://github.com/rubiin/init.lua/commit/012cc90cbf05b3626bc742f30ecb19ef3b27d45d))
* **config:** refresh lazy-lock, add spellfixes, and tune lualine separators ([682551f](https://github.com/rubiin/init.lua/commit/682551f1ec923bea4c603ce3fcfa85a8af91f444))
* **keymaps/autocmds/neogit:** use Snacks.keymap API instead of vim.keymap ([116425d](https://github.com/rubiin/init.lua/commit/116425dda1188a2e45b25ee350124ace381b5c86))
* **lazy-lock,autocmds,keymaps:** update lazy-lock entries; use local cmd alias; change escape mapping to jk (noremap) ([eb3f664](https://github.com/rubiin/init.lua/commit/eb3f6649e5d6891a7bb6e4e9eaf2d93ae7a8ee48))
* move Copilot lualine status into ui/lualine.lua and remove standalone ai.lua ([5352ac4](https://github.com/rubiin/init.lua/commit/5352ac429f8b5ba35111bac830e7b465ecf84a2e))
* normalize ftplugin formatting, add spelllang, spellfile and pre-commit config ([6eaebea](https://github.com/rubiin/init.lua/commit/6eaebea1857e0b15b7d39f8dcdd00838f2a784ca))
* **plugins:** enable Neogit and remove tokyonight disable override ([1ab33be](https://github.com/rubiin/init.lua/commit/1ab33be66ddcb9a665e764c264ab049087565aaa))
* refactor rainbow-delimiters config, add language queries & priorities; fix session whitespace ([95f407e](https://github.com/rubiin/init.lua/commit/95f407eccd0ece2badccf60ff724f30e214324c4))
* refresh lazy-lock.json plugin pins ([535961e](https://github.com/rubiin/init.lua/commit/535961ee01aac654a317ffa09c63ab07a192bf3e))
* relocate LazyVim settings to overrides.lua; convert git-conflict setup to opts and add descriptive keymaps ([fa8eeb2](https://github.com/rubiin/init.lua/commit/fa8eeb2856ac4b45b550092ebdbf9a5c4d6dd7ca))
* remove M.cowboy helper, disable spell in qf ftplugin, refresh lazy-lock.json ([4c65973](https://github.com/rubiin/init.lua/commit/4c659734989b2deae60be263e5f0053c3d264cfe))
* remove nvim-lightbulb plugin config and refresh lazy-lock.json ([efdb390](https://github.com/rubiin/init.lua/commit/efdb3909b1b2c5d5265a733fe86bdfcba71e8191))
* remove redundant 'scheme' filetype mapping ([93cdc68](https://github.com/rubiin/init.lua/commit/93cdc683c5ac803ee3e0cacf85fd6e4469cb8889))
* reorganize autocmds and disable LazyVim default autocmds ([bf14681](https://github.com/rubiin/init.lua/commit/bf146810f6a65c2d04bc35c65e3de33a7a470046))
* simplify auto-session root_dir and remove cwd_change_handling ([e5ca395](https://github.com/rubiin/init.lua/commit/e5ca3953686050b9ef671ae12d722bc66d771bcd))
* switch session plugin to auto-session, refresh lockfile, add markdownlint and neogit stub ([108a5f0](https://github.com/rubiin/init.lua/commit/108a5f061e47c8e1655bb0208cd97dad6de28a44))
* switch to Snacks.keymap.set for key mappings in ftplugins and utils ([10693e0](https://github.com/rubiin/init.lua/commit/10693e042bcbaece099b20385485b7bd38af2baf))
* switch to Snacks.keymap.set, remove custom keymap helpers, bump snacks.nvim, fix lualine formatting ([77b44cd](https://github.com/rubiin/init.lua/commit/77b44cd18ba0d378d199b7aeae3a52ddc2707b80))
* update catppuccin commit in lazy-lock.json (bump to 8c4125e) ([1c7c292](https://github.com/rubiin/init.lua/commit/1c7c2921823c19156965e847113635ec4f8d1c69))
* update lazy-lock pins for noice.nvim and snacks.nvim ([02bc96f](https://github.com/rubiin/init.lua/commit/02bc96fb9ef5aef646fda460db0a6c5ea50e47a8))
* update mason-lspconfig.nvim commit in lazy-lock.json ([92df767](https://github.com/rubiin/init.lua/commit/92df767e74577f5c5b1f231cd4074e2e3e89ba50))
* update plugin commit pins in lazy-lock.json ([919544f](https://github.com/rubiin/init.lua/commit/919544fd5f91001c6d6eefaf4b465f49b98ae3cb))
* use %R time format in gitsigns current_line_blame_formatter ([60aaf83](https://github.com/rubiin/init.lua/commit/60aaf83e6bbc629b9beaa8709cd0bc8ed5a33079))


### 🚀 CI Improvements

* update vimdoc config ([3be1ffd](https://github.com/rubiin/init.lua/commit/3be1ffde33fa9656469c8e2e1c2ef87c8cdeb3d0))

## [2.8.0](https://github.com/rubiin/init.lua/compare/v2.7.2...v2.8.0) (2025-10-23)


### 🚀 New Features

* add autocmd to apply chezmoi changes on saving dotfiles ([ba701fa](https://github.com/rubiin/init.lua/commit/ba701faa12cd5b4bc4da808c51fd5e5125f61765))
* add colorizer plugin configuration for enhanced color highlighting ([c6bf600](https://github.com/rubiin/init.lua/commit/c6bf600ea898e6d923693457aff75146ab28f38c))
* add nvim-lightbulb plugin configuration for enhanced code insight ([90231cc](https://github.com/rubiin/init.lua/commit/90231cce2ddc882cf02980b38f046ad553dcfffb))
* add precognition ([7d69f2c](https://github.com/rubiin/init.lua/commit/7d69f2c32c193e2864c80f85b20f3c1265ef8697))
* enhance auto-save functionality with detailed event handling and conditions ([31eeeb3](https://github.com/rubiin/init.lua/commit/31eeeb34b7aaaeefbe90658e6d22fd2eb69504b8))
* replace nvim-highlight-colors with nvim-colorizer.lua for enhanced color highlighting ([0d45802](https://github.com/rubiin/init.lua/commit/0d45802345bdf6135bb1c037cd09d97a4a03db01))
* update chezmoi command to exclude encrypted files on dotfile save ([83f3014](https://github.com/rubiin/init.lua/commit/83f3014afc7de201b5f461806fba8b406a9c0b44))


### 🐛 Bug Fixes

* add "Snacks" to diagnostics.globals in .luarc.json ([6890257](https://github.com/rubiin/init.lua/commit/6890257d93cc1732b648916bd9a0e438d1333872))
* add missing configuration for ts-comments.nvim plugin ([7cc56d7](https://github.com/rubiin/init.lua/commit/7cc56d7fc0c2f71420d9424d4ab18635a72e801c))
* **autosave:** unify BufLeave handler to re-enable auto-save for snacks_input and snacks_picker ([c6dccef](https://github.com/rubiin/init.lua/commit/c6dccef515f9c0f8a600db35b5d30cd419211c61))
* enable ts_context_commentstring integration by removing skip_ts_context_commentstring_module ([7e855a4](https://github.com/rubiin/init.lua/commit/7e855a4150dbcaf1c043074e0b4d59389c966eb5))
* ensure comment string is not nil in add_author_details function ([47dddd9](https://github.com/rubiin/init.lua/commit/47dddd90b99532b87af4a82108f766db94ff3ea6))
* only fix the lua line for copilot ([a9ae0ca](https://github.com/rubiin/init.lua/commit/a9ae0ca76bd70dd9d870fa8c1e3c7221a4d10eaf))
* re-enable autosave during active luasnip snippets by removing in_snippet guard ([63dac84](https://github.com/rubiin/init.lua/commit/63dac84fa7d627dc4579622d12f1d26727b2990c))
* remove mini.hipatterns from lazy-lock and lazyvim configurations ([4430a1a](https://github.com/rubiin/init.lua/commit/4430a1a3ceba1cee5957175a4623a781995022f8))
* remove projects.nvim ([601d1a4](https://github.com/rubiin/init.lua/commit/601d1a41c8b8b3d1cdc1ea7e94cc26c7acee3d37))
* remove trailing spaces in function abbreviation mappings across multiple language configurations ([1657a7c](https://github.com/rubiin/init.lua/commit/1657a7c83146b0c05d8afdf878487f5244ae6452))
* remove unnecessary dependencies from plugin configurations ([87815d7](https://github.com/rubiin/init.lua/commit/87815d729e2dd948dc893d0d13aa8029455a63f5))
* remove unused Wakatime integration code ([4d9bac5](https://github.com/rubiin/init.lua/commit/4d9bac57dffe959bc8e971672416708461856f9e))
* snacks jumps ([1e405f7](https://github.com/rubiin/init.lua/commit/1e405f790b375d32bb4065d52f03883eff077aa1))
* snacks layout to telescope ([a58b9ae](https://github.com/rubiin/init.lua/commit/a58b9aeb576f629666d707f9419f7cc62f5e8fa5))
* update copilot status reference in ai.lua ([46aec08](https://github.com/rubiin/init.lua/commit/46aec0853620dcc5bd02231ed4957d00c59b6f15))
* update function abbreviation in multiple language configurations ([139fe21](https://github.com/rubiin/init.lua/commit/139fe2175e945e1b779ddd0d51910c44942fccd7))
* update plugin identifiers and disable persistence plugin in configuration ([196407e](https://github.com/rubiin/init.lua/commit/196407efd17762ff6211f0b2263f66c5c22b1f6e))
* update repo names for plugins ([9d6d6dc](https://github.com/rubiin/init.lua/commit/9d6d6dc6e398b2f3c60ce06807984d3cace74aba))
* update snacks layout preset to telescope in action-preview configuration ([04047ee](https://github.com/rubiin/init.lua/commit/04047eeefb759f5cde2aa0e064a3aa72bbe602e0))
* use snacks project ([430ded6](https://github.com/rubiin/init.lua/commit/430ded69e6a2d0afb69a53331d3f804e0a5e97cc))
* use snacks undotree instead of undo tree plugin ([7f3d831](https://github.com/rubiin/init.lua/commit/7f3d831c53f47e03733bd267e219b9b77ddaac11))


### 🎨 Code Style

* **colorizer:** normalize inline comments and whitespace in colorizer setup ([c6dccef](https://github.com/rubiin/init.lua/commit/c6dccef515f9c0f8a600db35b5d30cd419211c61))


### ⚙️ Chores

* add BufRead lazy-load for rubiin/goodies.nvim and reorder vimwordlist.nvim fields ([14bf63a](https://github.com/rubiin/init.lua/commit/14bf63afa44b9c2bd41a1a1328406029d7773b4f))
* add key-analyzer plugin and autocmd to clear yazi cache on save ([42d0dac](https://github.com/rubiin/init.lua/commit/42d0dac357cbcf592c9e102dd8da4f61005359a1))
* add local goodies.nvim and tidy related utils/keymaps; update README & lockfile ([ac6d259](https://github.com/rubiin/init.lua/commit/ac6d259272a208d4805ab97d4fd4a57ff05b1929))
* add oxlint to mason ensure_installed ([ec53904](https://github.com/rubiin/init.lua/commit/ec539048a697bce817a44e1218ef31156f22ced7))
* comment out sample colorscheme plugin blocks (onedarkpro, vscode, material) in lua/plugins/ui/colorscheme.lua ([4a9d700](https://github.com/rubiin/init.lua/commit/4a9d70053074c0c03049b01b20330e08c94ec78f))
* consolidate snacks.nvim and mini.icons into plugins/overrides.lua; remove lua/plugins/snacks.lua ([99b6958](https://github.com/rubiin/init.lua/commit/99b695883d9c4732cc0577df8e0bc9a5d5463d08))
* migrate plugins from config() to opts for lazy setup and add dashboard startup print ([5fcf8c9](https://github.com/rubiin/init.lua/commit/5fcf8c975d69bb6208960d338ed51eb29c71d029))
* move LazyVim globals to globals.lua, tidy configs, add blink extra, and update lockfile ([fa3847e](https://github.com/rubiin/init.lua/commit/fa3847e2decb714d6d5a3349d3e1bbf10a272dc3))
* refresh lazy-lock.json ([c6dccef](https://github.com/rubiin/init.lua/commit/c6dccef515f9c0f8a600db35b5d30cd419211c61))
* refresh lazy-lock.json and set persisted session default_branch to master ([812c4a4](https://github.com/rubiin/init.lua/commit/812c4a4b4ce4f338321256795fe9a1a05eb85191))
* refresh lockfile, remove leap extra, and tidy configs ([94adc59](https://github.com/rubiin/init.lua/commit/94adc5916cae744b36b88f683fd99a4b30b0becb))
* remove BufRead lazy-load for rubiin/goodies.nvim and refresh spellfile ([bfcefb9](https://github.com/rubiin/init.lua/commit/bfcefb9ac2f09d9be6f7490e678c06065d213768))
* remove DAP/test extras and prune related plugins; disable tokyonight; add ts-comments language mappings ([766404e](https://github.com/rubiin/init.lua/commit/766404e8597a7615218cd0facaf964c33b55f332))
* remove devicons settings from cybu config and tidy exclude filetypes order ([f002d84](https://github.com/rubiin/init.lua/commit/f002d846662ea3690730670eec8f735d569a7f2e))
* remove go language extra from lazyvim.json ([3eefc0c](https://github.com/rubiin/init.lua/commit/3eefc0c5ef05e6ff797b897009b8b743e2dc3811))
* remove key-analyzer plugin import and lockfile entry ([0b4cbe5](https://github.com/rubiin/init.lua/commit/0b4cbe562d484a929f841336aac49229de74df06))
* remove markdownlint from nvim-lint config and update lazy-lock.json ([6f70438](https://github.com/rubiin/init.lua/commit/6f70438a1a0f1a0b9133d42c8a490a3b3d6e1ebe))
* switch goodies keymaps to top-level API and enable author details mapping ([4307d17](https://github.com/rubiin/init.lua/commit/4307d17cd4bd7745a4cee97a35a5b3db4d40459f))
* tidy plugin configs, defer ts-context pre_hook, and fix lazy.stats require ([59cfd86](https://github.com/rubiin/init.lua/commit/59cfd86861305f2db5128ea391a81720c3a90346))


### ♻️ Code Refactoring

* remove flash.jump overrides to streamline auto-save functionality ([922395c](https://github.com/rubiin/init.lua/commit/922395c518f5888fa111ed8ff01680574e1d3052))
* standardize usage of ft_abbr function across multiple language configurations ([25f0f6d](https://github.com/rubiin/init.lua/commit/25f0f6de397e76c3b6768004426d0e0e7e9e39ff))


### 🚀 CI Improvements

* update vimdoc config ([6032421](https://github.com/rubiin/init.lua/commit/60324215fa65846edc9266a2c9940471b55e2ed8))

## [2.7.2](https://github.com/rubiin/init.lua/compare/v2.7.1...v2.7.2) (2025-08-27)


### 🐛 Bug Fixes

* install packages command ([#70](https://github.com/rubiin/init.lua/issues/70)) ([9ffd24a](https://github.com/rubiin/init.lua/commit/9ffd24ac3415bd10bb22c22283e32703a35b8b20))

## [2.7.1](https://github.com/rubiin/init.lua/compare/v2.7.0...v2.7.1) (2025-08-14)


### 🚀 CI Improvements

* update permissions ([54400e9](https://github.com/rubiin/init.lua/commit/54400e9c3ac52c44290216c228f5a5dcfdc5ebb2))
* update release please ([17dd174](https://github.com/rubiin/init.lua/commit/17dd174a27a25084985f5e301c41273d8af8bc5a))

## [2.7.0](https://github.com/rubiin/init.lua/compare/v2.6.0...v2.7.0) (2025-08-13)


### Features

* harpoon to 9 ([8de8600](https://github.com/rubiin/init.lua/commit/8de8600c44ed445f9e18c98ce7d9a838a344ba74))
* snacks dim and zen ([dbfdda0](https://github.com/rubiin/init.lua/commit/dbfdda0ea5da0864caafca01a7f0142bce32df44))

## [2.6.0](https://github.com/rubiin/init.lua/compare/v2.5.8...v2.6.0) (2025-08-13)


### Features

* harpoon to 9 ([8de8600](https://github.com/rubiin/init.lua/commit/8de8600c44ed445f9e18c98ce7d9a838a344ba74))
* snacks dim and zen ([dbfdda0](https://github.com/rubiin/init.lua/commit/dbfdda0ea5da0864caafca01a7f0142bce32df44))

## [2.5.8](https://github.com/rubiin/init.lua/compare/v2.5.7...v2.5.8) (2024-07-24)


### Bug Fixes

* deps ([681e88e](https://github.com/rubiin/init.lua/commit/681e88ebf50cc291c83a99cc04eeb2fd19edb1ae))
* remove spectre ([a793255](https://github.com/rubiin/init.lua/commit/a793255bb2e1277d540cc1f89190e0b97be11310))

## [2.5.7](https://github.com/rubiin/init.lua/compare/v2.5.6...v2.5.7) (2024-07-16)


### Bug Fixes

* **todo:** fix extra keywords ([042e48a](https://github.com/rubiin/init.lua/commit/042e48a8dde04eb48641fd541be415a90b76e7dc))
* which key fix ([b931ff4](https://github.com/rubiin/init.lua/commit/b931ff40ab3851edf6fcb9f337026ad3cfcf79bd))
* whichkey format ([1226323](https://github.com/rubiin/init.lua/commit/12263239a5a15165438208bb9f54e1582594ecd8))

## [2.5.6](https://github.com/rubiin/init.lua/compare/v2.5.5...v2.5.6) (2024-07-05)


### Bug Fixes

* add back themes ([88ba4fb](https://github.com/rubiin/init.lua/commit/88ba4fb48de4428c851fab6d4a77ce6e399f14c4))
* deps ([19b0ac5](https://github.com/rubiin/init.lua/commit/19b0ac5dfd3bea74850d340f2e13ae5550c6957a))

## [2.5.5](https://github.com/rubiin/init.lua/compare/v2.5.4...v2.5.5) (2024-06-25)


### Bug Fixes

* deps ([ab45bb9](https://github.com/rubiin/init.lua/commit/ab45bb914b7482e29eeea81d105236f4a345d85a))
* new personal vim folder ([ab9078f](https://github.com/rubiin/init.lua/commit/ab9078fb730d7daa6c1c2c0251db4dfcba6d6561))
* remove bigfile as lazy handles it internally ([6b4c179](https://github.com/rubiin/init.lua/commit/6b4c1797f7c0e5de9683c132465a1db4ec846f5b))

## [2.5.4](https://github.com/rubiin/init.lua/compare/v2.5.3...v2.5.4) (2024-06-23)


### Bug Fixes

* disable noice signature help ([20b226b](https://github.com/rubiin/init.lua/commit/20b226b18d3351f5109911b650309208cf4b5fd8))
* follow text while typing ([53cecd1](https://github.com/rubiin/init.lua/commit/53cecd1b5a6ecceb56976efc608174f8363a94b2))
* go hello world snip ([aa15e9b](https://github.com/rubiin/init.lua/commit/aa15e9bcfcdc30f1752c02789c0a956ad3080940))
* remove custom lsp config ([72617f9](https://github.com/rubiin/init.lua/commit/72617f9b538dce0214ca6c8e6e8472c8b618a0ec))

## [2.5.3](https://github.com/rubiin/init.lua/compare/v2.5.2...v2.5.3) (2024-06-20)


### Bug Fixes

* before keymap assign, check if fzf-lua exists ([9317887](https://github.com/rubiin/init.lua/commit/9317887fb06063cfe2c9c6719ec61c3f5057057b))
* remove neotree hidden file notif ([94b686f](https://github.com/rubiin/init.lua/commit/94b686fc4c55afa0bf709bd59f1ae03f4579f79c))
* spell and deps ([571f441](https://github.com/rubiin/init.lua/commit/571f4416f32122c8ef2ae733862027beb4714028))

## [2.5.2](https://github.com/rubiin/init.lua/compare/v2.5.1...v2.5.2) (2024-06-14)


### Bug Fixes

* install eslint_d by default ([a129d2b](https://github.com/rubiin/init.lua/commit/a129d2bbfb1b75d334b6e67d238740b4bee67b12))

## [2.5.1](https://github.com/rubiin/init.lua/compare/v2.5.0...v2.5.1) (2024-06-14)


### Bug Fixes

* undo tree use right ([61a8497](https://github.com/rubiin/init.lua/commit/61a8497cb03b675e65d91f14dc559c65d448cc03))

## [2.5.0](https://github.com/rubiin/init.lua/compare/v2.4.3...v2.5.0) (2024-06-14)


### Features

* trouble winbar ([2cf7375](https://github.com/rubiin/init.lua/commit/2cf73755b852a19fbad0f7fd4d45b72c941314af))


### Bug Fixes

* colorscheme ([770b90f](https://github.com/rubiin/init.lua/commit/770b90fef07e6b7ba17a82ea0790cb41d506bba8))
* dashboard ([054b298](https://github.com/rubiin/init.lua/commit/054b298ed58a8d43a756539ef28ce79805066935))
* dashboard use Lazyvim.pick ([dcfd12e](https://github.com/rubiin/init.lua/commit/dcfd12ee12d387a8cd669591c5adf4f31c2ba22c))
* deps ([1a46d2a](https://github.com/rubiin/init.lua/commit/1a46d2a4237c1019ee132b93ea2b10d38d4fde3e))
* fzf-lua bottom like telescope ([f2a5a73](https://github.com/rubiin/init.lua/commit/f2a5a73ebcea67f16687df124d978273e8d50984))
* telescope to fzf-lua ([2069773](https://github.com/rubiin/init.lua/commit/206977362b3dd1be7070e7eb7885f5673b4cffb1))
* trouble move with tab ([a59b4fe](https://github.com/rubiin/init.lua/commit/a59b4fe979093c3f05fe0cd4df631ba0cd5dd9c1))
* updates ([005700f](https://github.com/rubiin/init.lua/commit/005700f33d9e5d4f0880c362fdcec120565ee7b3))
* use fzf spell suggest ([adc8f54](https://github.com/rubiin/init.lua/commit/adc8f54f122356621377c5cbae43d2d5305d3e72))
* use undotree ([4928f98](https://github.com/rubiin/init.lua/commit/4928f9867bc3e85de14d7fc03339db93fd1442f4))

## [2.4.3](https://github.com/rubiin/init.lua/compare/v2.4.2...v2.4.3) (2024-06-09)


### Bug Fixes

* dont enable spell by default ([d0f9e2e](https://github.com/rubiin/init.lua/commit/d0f9e2ed70b2cb20e2407e706c8b1a5a187118b4))
* enable lazyvim options ([0c16797](https://github.com/rubiin/init.lua/commit/0c167971fd479a9dbe3c7295cf0eae4134f3808d))
* load telescope extension on their own files ([c91d2bf](https://github.com/rubiin/init.lua/commit/c91d2bf176623c2d56bfb3521ae2334fc9525e8c))
* move lazyvim globals to options ([9a3b244](https://github.com/rubiin/init.lua/commit/9a3b244908448486d43935d063fd24c0c4f85cc3))
* remove barbeque ([e16a7bb](https://github.com/rubiin/init.lua/commit/e16a7bbc0c0a8866a147939f30e90fa48871dd35))
* **theme:** use tokyonight ([58f6a21](https://github.com/rubiin/init.lua/commit/58f6a218f7bacdbc0da88a29261134545a1ea582))

## [2.4.2](https://github.com/rubiin/init.lua/compare/v2.4.1...v2.4.2) (2024-06-06)


### Bug Fixes

* configuration upstream ([8525759](https://github.com/rubiin/init.lua/commit/8525759f8278408c375a9d312930bda00ba1ce2b))
* folds and inc rename ([28717f8](https://github.com/rubiin/init.lua/commit/28717f8ef7383444f05eea09a222648fcbe54c9a))
* icons ([ff3da25](https://github.com/rubiin/init.lua/commit/ff3da252667cf8818558e8862cf7f5801b8d40ce))

## [2.4.1](https://github.com/rubiin/init.lua/compare/v2.4.0...v2.4.1) (2024-06-04)


### Bug Fixes

* dashboard quit ([405dbe6](https://github.com/rubiin/init.lua/commit/405dbe6e08c16faa0dfb45ebc01d265bf1c0d76f))
* new horizontal keymaps ([bb9a7ca](https://github.com/rubiin/init.lua/commit/bb9a7ca2abc07564c3d61fa0b2ff01ab61242627))
* trouble filters ([8ff3ba6](https://github.com/rubiin/init.lua/commit/8ff3ba66ee244d1714d6571251524846cc1178af))
* trouble keymaps for telescope ([cff8826](https://github.com/rubiin/init.lua/commit/cff88266f04681ef6fc0c23030c7bd8d8706ff96))
* trouble toggle ([4d7e546](https://github.com/rubiin/init.lua/commit/4d7e546ecc77b3974801a8ec896b944149aba5f5))

## [2.4.0](https://github.com/rubiin/init.lua/compare/v2.3.1...v2.4.0) (2024-06-02)

### Features

- use lazydev lsp for lua ([8bd0705](https://github.com/rubiin/init.lua/commit/8bd0705c3d712e071f2fa6f042c310d9bd57edc4))

### Bug Fixes

- remove trouble lualine ([f114874](https://github.com/rubiin/init.lua/commit/f11487432d411b1969c102aca886850648a13441))
- update deps ([b4624e5](https://github.com/rubiin/init.lua/commit/b4624e5bc04415eb815a18fba2e396e292bb2198))

## [2.3.1](https://github.com/rubiin/init.lua/compare/v2.3.0...v2.3.1) (2024-05-31)

### Bug Fixes

- just keep catpuccin ([0b0c166](https://github.com/rubiin/init.lua/commit/0b0c166311e3a0d3efa074060734ba09148bc553))
- remove better escape , use jj instead ([97938ad](https://github.com/rubiin/init.lua/commit/97938ad3e6b42c4cd62610fb22c4d46c26bafae2))
- remove refactoring as no longer used ([cb3f7b2](https://github.com/rubiin/init.lua/commit/cb3f7b2f83461a06b88784730ab59a661df6154d))
- use lazy.json ([438f49c](https://github.com/rubiin/init.lua/commit/438f49c2187c5f4908bc06bbf37740d7e3fbec3b))

## [2.1.0](https://github.com/rubiin/init.lua/compare/v2.0.1...v2.1.0) (2024-05-25)

### Features

- **keymaps:** add goto start and end of command on terminal ([9dadc7b](https://github.com/rubiin/init.lua/commit/9dadc7b386c3710973e5012fd9da0e39a8b0b97d))
- **keymaps:** add redo keymap ([2024f76](https://github.com/rubiin/init.lua/commit/2024f76908c94b23b12e27f5c4c8a0b5688d14c7))
- **spell:** add programming related spell file ([9dadc7b](https://github.com/rubiin/init.lua/commit/9dadc7b386c3710973e5012fd9da0e39a8b0b97d))

### Bug Fixes

- remove mini pairs ([8fc35a9](https://github.com/rubiin/init.lua/commit/8fc35a96c31e5f19a435e36b6018773cb684ba29))
- remove unneeded configs ([7f92f74](https://github.com/rubiin/init.lua/commit/7f92f748d2ba4f47dd30b4a589f601e8621c03ed))
- use extension instead ([c514e7a](https://github.com/rubiin/init.lua/commit/c514e7a9e072ff1f00a418f9bb0f08bb4ddd843c))

## [2.0.1](https://github.com/rubiin/init.lua/compare/v2.0.0...v2.0.1) (2024-05-23)

### Bug Fixes

- autocmd bug ([af860d8](https://github.com/rubiin/init.lua/commit/af860d8a8be97c416f561e41c47fadd29eb480ff))

## [2.0.0](https://github.com/rubiin/init.lua/compare/v1.7.7...v2.0.0) (2024-05-23)

### Features

- add horizontal comment line with hr ([09d3921](https://github.com/rubiin/init.lua/commit/09d3921c3b7cd7498e529a87d17004a48935ff36))
- add job to update config ([88d4e47](https://github.com/rubiin/init.lua/commit/88d4e4739e873e6f1c6cf604a99876ab9f49d201))
- **completion:** add cmp cmdline completion ([3b96578](https://github.com/rubiin/init.lua/commit/3b96578e536a2f68f63e39285b48f257fe6c0949))
- **dot:** add dotenv for dotfiles ([855b145](https://github.com/rubiin/init.lua/commit/855b1453755d14c0057bcd1abba1b98da4eb438b))
- generic pleanary job ([3a9260f](https://github.com/rubiin/init.lua/commit/3a9260f0e77787c3bc6e7031ff0f1ce313e93146))
- get builin themes automatically ([fd46c97](https://github.com/rubiin/init.lua/commit/fd46c97a80bc85e2b2041c12dd1438772b770372))
- **keymaps:** add keymaps for pasting above and below ([d1e94d2](https://github.com/rubiin/init.lua/commit/d1e94d27b77f518025276cb2b9017f5ae7e86734))
- lazyvim depraction option ([ff0cb94](https://github.com/rubiin/init.lua/commit/ff0cb94f83e0842ccef5e0dba58ab1a1c22e619d))
- **lightbulb:** custom lightbulb from laspsaga ([4d9d60c](https://github.com/rubiin/init.lua/commit/4d9d60c24c390802c9fadcd208402e757905c4ad))
- lsp formatting ([7f9dae5](https://github.com/rubiin/init.lua/commit/7f9dae55bcb0e1bbb3aff783309c963be626d524))
- **luasnip:** add snippets for go and sql ([d3f122c](https://github.com/rubiin/init.lua/commit/d3f122c32b41ac475bf7a7dd7bf34a09317627f8))
- **markdown:** use lazyvim markdown ([d367a3f](https://github.com/rubiin/init.lua/commit/d367a3f01a4e72cd5e8413522a5aaade21c7d707))
- more banners ([a47810f](https://github.com/rubiin/init.lua/commit/a47810ffddf753bdaf26aead25043d3e4bfe71b1))
- move all globals to single file ([2ed66fa](https://github.com/rubiin/init.lua/commit/2ed66faf32d37a04eb1151d1e4021a1c80ef968b))
- neovim 10 🎉🥳 ([2ea1864](https://github.com/rubiin/init.lua/commit/2ea1864c8018f3e6e5a7ffee02568b2cce6bfa3b))
- noice routes mini ([8f75dfa](https://github.com/rubiin/init.lua/commit/8f75dfa94d9140e10b8628d39602cdea5737a284))
- start using LazyVim global ([517af5d](https://github.com/rubiin/init.lua/commit/517af5d906d8ed23c1ba3b64617ce178d536ee20))
- tmux source on file update ([978145c](https://github.com/rubiin/init.lua/commit/978145cb4b7b6923d34569516d7576036aa4c450))
- use lazyvims dial ([8fb3bb0](https://github.com/rubiin/init.lua/commit/8fb3bb0407a9d200d0e6986b9cacb9890fdf666b))

### Bug Fixes

- add bash support with dot ([774d39e](https://github.com/rubiin/init.lua/commit/774d39e442f34cf88fff3c4d3fc3d011eb7f6f27))
- add buffer runner ([7113964](https://github.com/rubiin/init.lua/commit/7113964a5630ba5d5dce9a3db2a6c0dc8398629f))
- add event to actions-preview ([d7d934d](https://github.com/rubiin/init.lua/commit/d7d934d004538d02fe20a2984f08e07964e3c254))
- add func to pull from github ([be8447c](https://github.com/rubiin/init.lua/commit/be8447c68830729fb1b76700e2cfb628e41ce908))
- add gore ([a8a9537](https://github.com/rubiin/init.lua/commit/a8a95372be898c578e7db8ae6852bbaf07fe2c87))
- add missing vim illuminate ([99788ea](https://github.com/rubiin/init.lua/commit/99788ea0a3e2c1742d545ed83b8c2554824a4765))
- add wakatime component ([8051f86](https://github.com/rubiin/init.lua/commit/8051f861f75acb9ae688610d2662c59c4c7eba50))
- autocomment on next line ([62b7499](https://github.com/rubiin/init.lua/commit/62b7499355e20666865a5b19ddc5e9319bafa1a9))
- cmp ([06dda7b](https://github.com/rubiin/init.lua/commit/06dda7b7daa921468f7e4f292f057ebf7cbb7490))
- cmp filetype ([3fb0705](https://github.com/rubiin/init.lua/commit/3fb0705eeb9ca6e9adef814abe7ed18b40a3a502))
- **completions:** add luasnip back ([ae7be06](https://github.com/rubiin/init.lua/commit/ae7be06193bdf498b6fe1ac26a39b5db45ba67b1))
- copilot ([a4628ce](https://github.com/rubiin/init.lua/commit/a4628ce4bd10081e5de87ee6b950ba65ecb3323b))
- disable mini comment ([6eca858](https://github.com/rubiin/init.lua/commit/6eca8585373d97d5e99d75d7e1e0d71cb155602c))
- dont override cmp config from lazy ([c09181a](https://github.com/rubiin/init.lua/commit/c09181a634efd9b4937508e13199cec8d0c6c4cf))
- earlier comment nvim issue ([7b144d2](https://github.com/rubiin/init.lua/commit/7b144d200eebebb88ee6c0f34393988575552e91))
- earlier comment nvim issue ([ce15385](https://github.com/rubiin/init.lua/commit/ce153850ccbe530b1962df9ab87db6ec5f6b51a3))
- fast and furious ([255c022](https://github.com/rubiin/init.lua/commit/255c0227a95f3aede21eaf13003b944a776fb7f5))
- fixes on many stuffs to account ([d9b5f93](https://github.com/rubiin/init.lua/commit/d9b5f933b9a474f539d4313a187dc610b0d7158d))
- freaking fast ([5d7628e](https://github.com/rubiin/init.lua/commit/5d7628ee39c10d164c29fed45c964418bde07acf))
- global snip and keymaps ([d555b05](https://github.com/rubiin/init.lua/commit/d555b05e7ee9f5e293a4e7df9919735d2938c236))
- install tsserver on typescript tools manually ([3ffd7a5](https://github.com/rubiin/init.lua/commit/3ffd7a57026097299639003c4f8f2be415e48bf8))
- iron ([0ea66af](https://github.com/rubiin/init.lua/commit/0ea66af778662a24aa829a95fd5a7ca9af2cf3ea))
- issue with comment.nvim ([c50f323](https://github.com/rubiin/init.lua/commit/c50f323e2c1019b44a85c937cf6095f93ee76af2))
- just bare minimum for sometimes ([eb4fd7c](https://github.com/rubiin/init.lua/commit/eb4fd7c282184a0907bacaacc8979f5c31a34517))
- **keymaps:** remove unneeded autocmd ([5382db2](https://github.com/rubiin/init.lua/commit/5382db2db70b34664ffe1d9370245237bc1d7b35))
- lazyload on buffpre ([2448ee6](https://github.com/rubiin/init.lua/commit/2448ee609719ff6992b92d3e655302354cc54dbe))
- md disable linelength validation ([1d7aa51](https://github.com/rubiin/init.lua/commit/1d7aa51d8169d9e8133b0a4ca431b4b244fae66b))
- misc changes ([c3db4d6](https://github.com/rubiin/init.lua/commit/c3db4d64fafd3214712e1a504604c97dce0be789))
- more lazy load ([164f064](https://github.com/rubiin/init.lua/commit/164f064d27d262fadf912fd2ef85ae2aa247c78c))
- move database to lang folder ([f063a9b](https://github.com/rubiin/init.lua/commit/f063a9bfb06dae9e1c81763853841b65349d7fd4))
- mux and mux ([fb13b10](https://github.com/rubiin/init.lua/commit/fb13b1051629f2bc8e3902ae3ee9857604dfe0be))
- my habits ([9223a46](https://github.com/rubiin/init.lua/commit/9223a4615c51c63cb4fd59557d67d5f45db639b1))
- **nodejs:** fix cmp npm for nodejs ([900358a](https://github.com/rubiin/init.lua/commit/900358ab10e111c70bf36466efe8a7c8c1e4bb88))
- **noice:** silence yank and paste notifications ([ac80090](https://github.com/rubiin/init.lua/commit/ac80090e3583ac9a192a742e80c55dfba913bb4c))
- nvim-snippets folder ([2134a9a](https://github.com/rubiin/init.lua/commit/2134a9a495f02f366ee6fee77cfbea1ec309dda2))
- remaining updates for 0.10 ([0b52260](https://github.com/rubiin/init.lua/commit/0b522600e655d2d3d4bd26478efb938f7c8c43e9))
- remove copilot icon lualine, fix ts lsp ([be86c17](https://github.com/rubiin/init.lua/commit/be86c1773331ef82f9a2ddc869b273b829e587f9))
- remove defualt filetypes ([08c658c](https://github.com/rubiin/init.lua/commit/08c658c1d3a09fd651f8401223190aebfef261ab))
- remove duplicate mason keymap ([c72a7b0](https://github.com/rubiin/init.lua/commit/c72a7b042de457a23e3f85291e3b4c44a5d7abf8))
- remove lspsaga ([0977563](https://github.com/rubiin/init.lua/commit/09775631725e3a61fe01cdeabfa8b897ec167c4d))
- remove lualine wakatime component ([a8cf66e](https://github.com/rubiin/init.lua/commit/a8cf66ea5d37b72860842643ee1ac49f0f123757))
- remove package-name from ci ([5ee3fe0](https://github.com/rubiin/init.lua/commit/5ee3fe08cd08985c8f57b6584a0781064c0c46e3))
- remove prettier infavor of prettierd ([8dcd2c8](https://github.com/rubiin/init.lua/commit/8dcd2c858c263a28664b33aa9fdbd06c8c4ea68b))
- remove query from ignorelist ([61a42c8](https://github.com/rubiin/init.lua/commit/61a42c8cdbd2a20fc032b4d6ce88e9de42b46522))
- remove spell ([31fa676](https://github.com/rubiin/init.lua/commit/31fa6768ba332cc4b7c3f37a609117e753b32daa))
- remove startuptime custom as its already there in lazy ([2251d5d](https://github.com/rubiin/init.lua/commit/2251d5d287ec6e094688f00048b96f189c0d76c2))
- remove uneeded snippet loads ([5021227](https://github.com/rubiin/init.lua/commit/5021227b8fe0e0050090a6308bbe3b6b02c6bd33))
- remove unused cmp stuffs ([14e31e4](https://github.com/rubiin/init.lua/commit/14e31e4e9b78aec8f4db5a0066b830f8452eda45))
- remove vue as lazy supports it out of box ([7336ad9](https://github.com/rubiin/init.lua/commit/7336ad90fed45dd763a23a1beb9879613529acbc))
- reroll noice change ([3d82d10](https://github.com/rubiin/init.lua/commit/3d82d1014279ba1242320bccb761725918765399))
- rethinking lazy ([446beae](https://github.com/rubiin/init.lua/commit/446beaefdce8c93f2e4a3254830bb26d5e767ce9))
- run go ([445e4e7](https://github.com/rubiin/init.lua/commit/445e4e7fa275929c75ced9d418353e2bf3031e34))
- runner ([3e26c1a](https://github.com/rubiin/init.lua/commit/3e26c1a730f1c4b7dd00bed8eed48aef6333d446))
- separate toml config ([7ea59d0](https://github.com/rubiin/init.lua/commit/7ea59d0784140f0f8b7272a3df792586e707a2d3))
- smaller lualine mode ([14722eb](https://github.com/rubiin/init.lua/commit/14722ebca0645b6ec0d7c2907f337ff0bd057b92))
- spectre, conform, etc ([85914df](https://github.com/rubiin/init.lua/commit/85914dfde52d6e57460bc5f123479bf458d52a9e))
- spell typos ([44fb6ac](https://github.com/rubiin/init.lua/commit/44fb6ac1be774ff5a6b14e466fac745c8b51ddc7))
- telescope all recent files ([ba4fc83](https://github.com/rubiin/init.lua/commit/ba4fc8352edaf3bfe5a4c15280088151d0459b71))
- telescope icon picker ([1070bd0](https://github.com/rubiin/init.lua/commit/1070bd069720701f2d64f11d86e1b4598b15216b))
- todo changes ([bf897ea](https://github.com/rubiin/init.lua/commit/bf897ea4f7245e3e98a03d175651a318786e65d3))
- **todo:** remove done todos ([00b47c3](https://github.com/rubiin/init.lua/commit/00b47c3f166eed80236c43c19451d70e3fb36ad1))
- treesite and docs ([d8e85a7](https://github.com/rubiin/init.lua/commit/d8e85a76b2fc76b09d06cb1f3ee6e55e0acc6817))
- ts code actions ([9b3c607](https://github.com/rubiin/init.lua/commit/9b3c60791c866f9a430c9c29e7dfde93eae0614b))
- ts lsp ([ec068e0](https://github.com/rubiin/init.lua/commit/ec068e0d09494cc4afaca9a7d865a24763c642cc))
- ts lsp keys ([7f77afc](https://github.com/rubiin/init.lua/commit/7f77afccfb11d16ba40c50779329ceb2083b9dd7))
- **typescript-tools:** custom config ([a8c9714](https://github.com/rubiin/init.lua/commit/a8c9714360047edca0927994508ec25ca855a9a4))
- **undotree:** make preview large ([dce9ea3](https://github.com/rubiin/init.lua/commit/dce9ea396ded3545b42877d417c52375aeb8fa47))
- use github copilot instead ([dc03411](https://github.com/rubiin/init.lua/commit/dc0341126a2ca1e14fa4b3e674bbb283f1c1eae2))
- use markdown.nvim infavor of headlines and glow ([4b6ab50](https://github.com/rubiin/init.lua/commit/4b6ab506a3f290e57bf9ae26227a482673ba7b0e))
- wakatime crash issue ([12b89da](https://github.com/rubiin/init.lua/commit/12b89da542a2ed64ff835d6e98890a65fe0cd41c))
- wakatime format change ([5784989](https://github.com/rubiin/init.lua/commit/578498926529a98ca5140fe0c482dbd703e89ba8))

### Performance Improvements

- **persisted:** lazyload persisted ([1ec52b1](https://github.com/rubiin/init.lua/commit/1ec52b1495b0f83e048721fa710f50e21aca90d6))

### Miscellaneous Chores

- release 2.0.0 ([35e99ce](https://github.com/rubiin/init.lua/commit/35e99cead064ab8c6efd5a87b0f4ad6ebdd4aaa6))
