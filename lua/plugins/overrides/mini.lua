return {
  {
    "nvim-mini/mini.icons",
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = function(_, opts)
      if not opts.file then
        opts.file = {}
      end
      if not opts.filetype then
        opts.filetype = {}
      end

      opts.file[".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" }
      opts.file["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" }
      opts.file[".nvmrc"] = { glyph = "", hl = "MiniIconsGreen" }
      opts.file[".node-version"] = { glyph = "", hl = "MiniIconsGreen" }
      opts.file["package.json"] = { glyph = "", hl = "MiniIconsGreen" }
      opts.file["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" }
      opts.file["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" }
      opts.file["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" }
      opts.file[".go-version"] = { glyph = "", hl = "MiniIconsBlue" }

      -- for prettier filetypes
      for _, filename in ipairs({
        ".prettierrc",
        ".prettierrc.cjs",
        ".prettierrc.cts",
        ".prettierrc.js",
        ".prettierrc.json",
        ".prettierrc.json5",
        ".prettierrc.mjs",
        ".prettierrc.mts",
        ".prettierrc.toml",
        ".prettierrc.ts",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        "prettier.config.cjs",
        "prettier.config.js",
        "prettier.config.mjs",
        "prettier.config.mts",
        "prettier.config.ts",
      }) do
        opts.file[filename] = { glyph = "", hl = "MiniIconsPurple" }
      end

      -- for eslint files

      local eslint_files = {
        -- ESLint <=8 (Deprecated)
        ".eslintignore",
        ".eslintrc",
        ".eslintrc.cjs",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        -- ESLint >=9
        "eslint.config.cjs",
        "eslint.config.cts",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.mts",
        "eslint.config.ts",
      }
      for _, filename in ipairs(eslint_files) do
        opts.file[filename] = { glyph = "󰱺", hl = "MiniIconsYellow" }
      end

      opts.filetype["gotmpl"] = { glyph = "󰟓", hl = "MiniIconsGrey" }
      opts.filetype["postcss"] = { glyph = "󰌜", hl = "MiniIconsOrange" }
    end,
  },
}
