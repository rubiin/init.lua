-- Better increase/descrease
return {
  "monaqa/dial.nvim",
  event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "<C-a>", function() return require("dial.map").inc_normal("custom") end, expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_normal("custom") end, expr = true, desc = "Decrement" },
    { "<C-a>", function() return require("dial.map").inc_normal("visual") end, mode = "v",  expr = true,       desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_normal("visual") end, mode = "v",  expr = true,       desc = "Decrement" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
      },
      typescript = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.new({ elements = { "let", "const" } }),
        augend.constant.new({ elements = { "public", "private", "protected" } }),
        augend.constant.new({ elements = { "any", "unknown", "never" } }),
        augend.constant.new({ elements = { "null", "undefined" } }),
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.constant.alias.Alpha,
      },
      custom = {
        augend.constant.new({
          elements = { "and", "or" },
          word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
          cyclic = true, -- "or" is incremented into "and".
        }),
        augend.constant.new({
          elements = { "True", "False" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "public", "private" },
          word = true,
          cyclic = true,
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
      },
    })
  end,
}
