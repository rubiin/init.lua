-- ========================================================================== --
-- ==                          File Types                                  == --
-- ========================================================================== --

-- Detect and assign filetype based on the extension or filename

vim.filetype.add({
  extension = {
    rofi = "rasi",
    wofi = "rasi",
    ejs = "html",
    htm = "html",
    mjml = "html",
    eta = "html",
    svx = "markdown",
    mdx = "markdown",
  },
  filename = {
    [".env"] = "dotenv",
    ["tsconfig.tsbuildinfo"] = "json",
    ["vifmrc"] = "vim",
    ["LICENCE"] = "markdown",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
    [".*docker[-]compose.*.yml"] = "docker-compose.yaml",
  },
})
