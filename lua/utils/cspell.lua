local utils = require("utils")

local M = {}

-- Original code from lazyvim-ide but modified to use cspell
-- Create cSpell.json if not exist
function M.create_cspell_json_if_not_exist()
  local cspell_json_path = utils.get_root_directory() .. "/cspell.json"

  if vim.fn.filereadable(cspell_json_path) == 0 then
    local file = io.open(cspell_json_path, "w")
    if file then
      local default_content = [[
{
  "$schema": "https://raw.githubusercontent.com/streetsidesoftware/cspell/main/cspell.schema.json",
  "version": "0.2",
  "language": "en",
  "cache": {
    "useCache": true,
    "cacheLocation": "./.cspell/.cspellcache",
    "cacheStrategy": "content"
},
  "globRoot": ".",
  "dictionaryDefinitions": [
    {
      "name": "cspell-tool",
      "path": "./cspell-tool.txt",
      "addWords": true
    }
  ],
  "dictionaries": [
    "cspell-tool"
  ],
  "features": {
    "weighted-suggestions": true
},
  "ignorePaths": [
    ".eslintignore",
    ".git",
    ".gitattributes",
    ".gitignore",
    ".github/integrations.json",
    ".pnp.{js,cjs}",
    ".prettierignore",
    ".yarn",
    "*.{png,jpg,pdf,svg}",
    "*.cpuprofile",
    "*.heapprofile",
    "**/.docusaurus/**",
    "**/.gitignore",
    "**/.vscode/**",
    "**/{cspell.*,cSpell.*,.cspell.*,cspell.config.*}",
    "**/*.schema.json",
    "**/*.snap",
    "**/*.trie",
    "**/coverage/**",
    "**/dist/**",
    "**/jest.config.js",
    "**/node_modules/**",
    "**/tsconfig.json",
    "/tools/*/lib/**",
    "/cspell-dict.txt",
    "/cspell-ignore-words.txt",
    "/docs/docsV2/**",
    "/docs/types/cspell-types",
    "/.cspell",
    "cspell*.{json,yaml}",
    "lcov.info",
    "package.json",
    "*-lock.{json,yaml}",
    "temp",
    "/cspell-tool.txt"
  ]
}
]]
      file:write(default_content)
      file:close()
    else
      utils.notify("Could not open cSpell dictionary", "error", "cSpell")
    end
  end
end

-- Add word to cSpell dictionary file
function M.add_word_to_cspell_dictionary()
  M.create_cspell_json_if_not_exist()

  local word = vim.fn.expand("<cword>")
  local dictionary_path = utils.get_root_directory() .. "/cspell-tool.txt"

  local file = io.open(dictionary_path, "r")
  if file then
    local word_found = false
    for line in file:lines() do
      if line == word then
        word_found = true
        break
      end
    end
    if word_found then
      utils.notify("Word already exists in the dictionary", "info", "cSpell")
      return
    end
  else
    utils.notify("Could not open cSpell dictionary", "error", "cSpell")
  end
  file = io.open(dictionary_path, "a")

  if file then
    local last_char = file:seek("end", -1)
    if last_char ~= nil and last_char ~= "\n" then
      word = "\n" .. word
    end

    file:write(word .. "")
    file:close()

    -- Save the current cursor position
    local current_cursor = vim.api.nvim_win_get_cursor(0)

    -- Reload the dictionary
    vim.cmd("e!")

    -- Set the cursor back to its original position
    vim.api.nvim_win_set_cursor(0, current_cursor)

    utils.notify("Word added to the dictionary", "info", "cSpell")
  else
    utils.notify("Could not open cSpell dictionary", "error", "cSpell")
  end
end

return M
