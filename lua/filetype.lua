-- ========================================================================== --
-- ==                          File Types                                  == --
-- ========================================================================== --

-- Detect and assign filetype based on the extension or filename

vim.filetype.add({
  extension = {
    ejs = "html",
    htm = "html",
    mjml = "html",
    eta = "html",
    svx = "markdown",
  },
  filename = {
    ["tsconfig.tsbuildinfo"] = "json", -- TODO: delete after merge
    ["LICENCE"] = "markdown",
  },
  pattern = {
    [".*docker[-]compose.*.yml"] = "docker-compose.yaml",
  },
})
