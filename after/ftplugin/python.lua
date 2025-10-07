--------------------------------------------------------------------------------
-- fix habits

local utils = require("utils")

utils.ft_abbr("true", "True")
utils.ft_abbr("false", "False")
utils.ft_abbr("//", "#")
utils.ft_abbr("--", "#")
utils.ft_abbr("null", "None")
utils.ft_abbr("nil", "None")
utils.ft_abbr("none", "None")
utils.ft_abbr("undefined", "None")
utils.ft_abbr("trim", "strip")
utils.ft_abbr("function", "def")
