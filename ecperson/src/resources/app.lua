local sys = require("sys")

local app = {}

app.NAME = "ecPerson"
app.VERSION = "0.1.1"
app.WEBSITE = "https://github.com/esferatec/ec-luart-managers/tree/main/ecperson"
app.COPYRIGHT = "(c) 2025"
app.DEVELOPER = "esferatec"

app.ARGUMENT = arg[1]

app.FILE = {
  path = sys.File(arg[0] or arg[-1]).path,
  name = sys.File(arg[0] or arg[-1]).name
}

app.SETTINGS = {
  file = sys.File(app.FILE.path .. "\\ecperson.json"),
  default = {
    LanguageEnglish = true,
    LanguageGerman = false,
  }
}

app.DATABASE = {
  fullpath = ":memory:",
  type = ".ecperson"
}

return app
