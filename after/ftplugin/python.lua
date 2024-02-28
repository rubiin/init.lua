--------------------------------------------------------------------------------
-- fix habits

local ft_abbr = require("utils").ft_abbr
ft_abbr("true", "True")
ft_abbr("false", "False")
ft_abbr("//", "#")
ft_abbr("--", "#")
ft_abbr("null", "None")
ft_abbr("nil", "None")
ft_abbr("none", "None")
