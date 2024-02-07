local utils = require("utils")

local M = {}

-- Original code from lazyvim-ide but modified

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
  "ignorePaths": [
    "node_modules",
    "dist",
    "build",
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
function M.add_word_to_c_spell_dictionary()
  M.create_cspell_json_if_not_exist()

  local word = vim.fn.expand("<cword>")
  local dictionary_path = utils.get_root_directory() .. "/cspell-tool.txt"

  local file = io.open(dictionary_path, "r")
  if file then
    -- read file to check the word exists or not

    local wordFound = false
    -- Loop through each line in the file
    for line in file:lines() do
      -- Check if the line contains only the word
      if line == word then
        wordFound = true
        break -- Stop reading further lines if the word is found
      end
    end
    if wordFound then
      utils.notify("Word already exists in the dictionary", "info", "cSpell")
      return
    end
  else
    utils.notify("Could not open cSpell dictionary", "error", "cSpell")
  end

  -- Append the word to the dictionary file
  file = io.open(dictionary_path, "a")
  if file then
    -- Detect new line at the end of the file or not
    local last_char = file:seek("end", -1)
    if last_char ~= nil and last_char ~= "\n" then
      word = "\n" .. word
    end

    file:write(word .. "")
    file:close()
    -- Reload buffer to update the dictionary
    vim.cmd("e!")
  else
    utils.notify("Could not open cSpell dictionary", "error", "cSpell")
  end
end

return M
