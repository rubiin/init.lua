local M = {}

-- lua line styles
M.styles = {
  slanted = "slanted",
  bubbly = "bubbly",
  default = "default",
}

-- common file types
M.common_file_types = {
  "dap-float",
  "fugitive",
  "fugitiveblame",
  "git",
  "help",
  "lspinfo",
  "man",
  "notify",
  "neo-tree",
  "dashboard",
  "null-ls-info",
  "none-ls-info",
  "PlenaryTestPopup",
  "qf",
  "query", -- :InspectTree
  "spectre_panel",
  "startuptime",
  "tsplayground",
  "lir",
  "DressingSelect",
  "packer",
  "lazy",
  "mason",
  "log",
  "lspsagafinder",
  "lspinfo",
  "dapui_scopes",
  "dapui_breakpoints",
  "dapui_stacks",
  "dapui_watches",
  "dap-repl",
  "toggleterm",
  "alpha",
  "coc-explorer",
  "checkhealth",
  "man",
  "gitcommit",
  "TelescopePrompt",
  "TelescopeResults",
  "Jaq",
}

M.ignore_binaries = {
  "%.7z",
  "%.avi",
  "%.JPEG",
  "%.JPG",
  "%.V",
  "%.RAF",
  "%.burp",
  "%.bz2",
  "%.cache",
  "%.class",
  "%.dll",
  "%.docx",
  "%.dylib",
  "%.epub",
  "%.exe",
  "%.flac",
  "%.ico",
  "%.ipynb",
  "%.jar",
  "%.gif",
  "%.bin",
  "%.jpeg",
  "%.jpg",
  "%.lock",
  "%.mkv",
  "%.mov",
  "%.mp3",
  "%.mp4",
  "%.m4a",
  "%.webm",
  "%.otf",
  "%.pdb",
  "%.pdf",
  "%.png",
  "%.rar",
  "%.sqlite3",
  "%.svg",
  "%.swp",
  "%.swf",
  "%.tar",
  "%.tar.gz",
  "%.ttf",
  "%.webp",
  "%.zip",
}

M.ignore_dirs = {
  ".git/",
  ".gradle/",
  ".idea/",
  ".vale/",
  ".vscode/",
  "__pycache__/*",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "smalljre_*/*",
  "target/",
  "vendor/*",
}

------------------------------------------------------------------------
--                              Plugin lists                          --
------------------------------------------------------------------------

--- TreeSitter parsers to keep installed
M.ts_parsers = {
  "css",
  "diff",
  "html",
  "svelte",
  "astro",
  "regex",
  "toml",
  "gitcommit",
  -- these five should always be installed, https://github.com/nvim-treesitter/nvim-treesitter#modules
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
}

return M
