local sys = require("sys")

local app = {}

app.NAME = "ecTask"
app.VERSION = "0.1.0"
app.WEBSITE = "https://github.com/esferatec/ec-luart-managers"
app.COPYRIGHT = "(c) 2024"
app.DEVELOPER = "esferatec"

app.ARGUMENT = arg[1]

app.FILE = {
  path = sys.File(arg[0] or arg[-1]).path,
  name = sys.File(arg[0] or arg[-1]).name
}

app.SETTINGS = {
  file = sys.File(app.FILE.path .. "\\ectask.json"),
  default = {
    LanguageEnglish = true,
    LanguageGerman = false,
  }
}

app.DATABASE = {
  fullpath = ":memory:",
  type = ".ectask"
}

return app
