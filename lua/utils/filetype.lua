-- Detect and assign filetype based on the extension or filename

vim.filetype.add({
  extension = {
    profile = 'sh',
    env = 'dotenv',
    json = 'jsonc',
    ejs = 'html',
    htm = 'html',
    mjml = 'html',
    eta = 'html',
    conf = 'conf',
    hbs = 'html',
    svx = 'markdown',
    mdx = 'markdown',
    svelte = 'svelte',
    rasi = 'css',
    norg = 'norg',
    patch = 'patch',
  },
  filename = {
    ['.env'] = 'dotenv',
    ['.zprofile'] = 'sh',
    ['.zshenv'] = 'sh',
    ['tsconfig.tsbuildinfo'] = 'jsonc',
    ['vifmrc'] = 'vim',
  },
  pattern = {
    ['%.env%.[%w_.-]+'] = 'dotenv',
    ['ignore$'] = 'ignore',
    ['rc$'] = 'ignore',
    ['%.json'] = 'jsonc',
  },
})
