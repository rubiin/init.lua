-- ========================================================================== --
-- ==                          File Types                                  == --
-- ========================================================================== --

-- Detect and assign filetype based on the extension or filename

vim.filetype.add({
  extension = {
    ejs = "html",
    mjml = "html",
    eta = "html",
    tsbuildinfo = "json"
  },
  pattern = {
    [".*docker[-]compose.*.yml"] = "docker-compose.yaml",
  },
})
