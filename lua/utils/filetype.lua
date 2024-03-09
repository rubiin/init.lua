-- ========================================================================== --
-- ==                          File Types                                  == --
-- ========================================================================== --

-- Detect and assign filetype based on the extension or filename

vim.filetype.add({
  extension = {
    profile = "sh",
    rasi = "rasi",
    rofi = "rasi",
    wofi = "rasi",
    env = "dotenv",
    json = "jsonc",
    ejs = "html",
    htm = "html",
    mjml = "html",
    eta = "html",
    conf = "conf",
    hbs = "html",
    svx = "markdown",
    mdx = "markdown",
    svelte = "svelte",
    norg = "norg",
    patch = "patch",
  },
  filename = {
    [".env"] = "dotenv",
    [".zprofile"] = "sh",
    [".zshenv"] = "sh",
    ["tsconfig.tsbuildinfo"] = "jsonc",
    ["vifmrc"] = "vim",
    ["LICENCE"] = "markdown",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["ignore$"] = "ignore",
    ["rc$"] = "ignore",
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/*.conf"] = "bash",
    [".*docker[-]compose.*.yml"] = "docker-compose.yaml",
    [".tmux.*"] = "conf",
  },
})
