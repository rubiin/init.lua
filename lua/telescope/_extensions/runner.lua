local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local utils = require("utils")

local scriptsTable = {}

local packageJson = utils.get_root_directory() .. "/package.json"

-- TODO: Implement this
