-- ========================================================================== --
-- ==                          File Types                                  == --
-- ========================================================================== --

-- Detect and assign filetype based on the extension or filename

vim.filetype.add({
  extension = {
    ejs = "html",
    mjml = "html",
    eta = "html",
    tsbuildinfo = "json",
    pipeline = "Jenkinsfile",
    stage = "Jenkinsfile",
    JenkinsFile = "Jenkinsfile",
    conf = "toml",
    h = "c",
    service = "systemd",
    tmux = "tmux",
  },
  filename = {
    ["dotshrc"] = "sh",
    ["dotsh"] = "sh",
    ["dotcshrc"] = "csh",
    ["gitconfig"] = "gitconfig",
  },
  pattern = {
    [".*docker[-]compose.*.yml"] = "docker-compose.yaml",
  },
})
