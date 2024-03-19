-- Better increase/decrease

local keymap = vim.keymap.set

return {
  "monaqa/dial.nvim",
  event = "VeryLazy",
  lazy = true,
  config = function()
    local augend = require("dial.augend")
    local default = {
      augend.constant.new({
        elements = { "and", "or" },
        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true, -- "or" is incremented into "and".
      }),
      augend.constant.new({
        elements = { "prod", "dev", "stage", "test" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "production", "development", "stage", "test" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eighth",
          "ninth",
          "tenth",
        },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "frappe", "latte", "macchiato", "mocha" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "include", "exclude" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "on", "off" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "before", "after" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "enable", "disable" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "start", "end" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "light", "dark" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      }),
      augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
      augend.constant.alias.bool, -- boolean value (true <-> false)
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.semver.alias.semver,
    }

    local typescript = vim.list_extend(default, {
      augend.constant.new({ elements = { "let", "const" } }),
      augend.constant.new({ elements = { "public", "private", "protected" } }),
      augend.constant.new({ elements = { "any", "unknown", "never" } }),
      augend.constant.new({ elements = { "null", "undefined" } }),
    })

    require("dial.config").augends:register_group({
      typescript = typescript,
      default = default,
      case = {
        augend.case.new({
          types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
          cyclic = true,
        }),
      },
    })
    local map = require("dial.map")
    -- change augends in VISUAL mode
    keymap("n", "<C-a>", map.inc_normal("default"), { noremap = true })
    keymap("n", "<C-x>", map.dec_normal("default"), { noremap = true })
    keymap("v", "<C-a>", map.inc_visual("default"), { noremap = true })
    keymap("v", "<C-x>", map.dec_visual("default"), { noremap = true })
    keymap("n", "~", map.inc_normal("case"), { noremap = true })
    keymap("v", "~", map.inc_visual("case"), { noremap = true })
  end,
}
