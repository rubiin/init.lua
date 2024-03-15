--------------------------------------------------------------------------------
-- INFO if abbreviations are not working, probably something has been mapped to
-- `<Space>` in insert mode
-----------------------------------------------------------------------------------

local spellfixes = {
  THe = "The",
  ahve = "have",
  brwoser = "browser",
  cant = "can't",
  cleitn = "client",
  curosr = "cursor",
  defualt = "default",
  definately = "definitely",
  doesnt = "doesn't",
  doestn = "doesn't",
  dont = "don't",
  dwon = "down",
  esle = "else",
  awiat = "await",
  fales = "false",
  fiel = "file",
  flase = "false",
  fo = "of",
  fodler = "folder",
  hwo = "how",
  ignroe = "ignore",
  guthib = "github",
  keybaord = "keyboard",
  lien = "line",
  markdwon = "markdown",
  mcuh = "much",
  msot = "most",
  mroe = "more",
  nromal = "normal",
  nto = "not",
  ntoe = "note",
  oepn = "open",
  onyl = "only",
  ot = "to",
  choer = "chore",
  reqire= "require",
  remtoe = "remote",
  reponse = "response",
  retrun = "return",
  retunr = "return",
  seperate = "separate",
  seperator = "separator",
  seperators = "separators",
  shwo = "show",
  sicne = "since",
  teh = "the",
  ti = "it",
  tiem = "item",
  tempalte = "template",
  treu = "true",
  ture = "true",
  verison = "version",
  woudl = "would",
}

for wrong, correct in pairs(spellfixes) do
  vim.cmd.inoreabbrev(wrong .. " " .. correct)
end
