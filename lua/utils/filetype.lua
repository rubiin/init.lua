
-- auto set filetype with this map

vim.filetype.add({
  extension = {
      profile = "sh",
      json = "jsonc",
      env = "sh",
      ejs = "html",
      eta = "html",
      hbs = "handlebars",
      svx = "markdown",
      mdx = "markdown",
      svelte = "svelte",
      rasi = "css",
      norg = "norg",
      patch = "patch",
  },
  filename = {
      env = "sh",
      bashrc = "sh",
      [".bashrc"] = "sh",
      [".zprofile"] = "sh",
      ["vifmrc"] = "vim",
      [".prettierrc"] = "jsonc",
      [".eslintrc"] = "jsonc",
      ["tsconfig.json"] = "jsonc",
      ["jsconfig.json"] = "jsonc",
  },
  pattern = {
      ["%.env%.[%w_.-]+"] = "sh",
  },
})

