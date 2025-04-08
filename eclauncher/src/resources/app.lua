local sys = require("sys")

local app = {}

app.TITLE = "ecLauncher"
app.VERSION = "0.1.1"
app.WEBSITE = "https://github.com/esferatec/ec-luart-managers"
app.COPYRIGHT = "(c) 2025"
app.DEVELOPER = "esferatec"

app.PATH = sys.File(arg[0] or arg[-1]).path
app.NAME = sys.File(arg[0] or arg[-1]).name

app.SETTINGS = {
  file = sys.File(app.PATH .. "eclauncher.json"),
  default = {
    LanguageEnglish = true,
    LanguageGerman = false,
  }
}

return app
