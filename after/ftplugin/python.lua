local ft_abbr = require("utils").ft_abbr
--------------------------------------------------------------------------------
-- fix habits


ft_abbr("true", "True")
ft_abbr("false", "False")
ft_abbr("//", "#")
ft_abbr("--", "#")
ft_abbr("null", "None")
ft_abbr("nil", "None")
ft_abbr("none", "None")
ft_abbr("undefined", "None")
ft_abbr("trim", "strip")
ft_abbr("function", "def")
