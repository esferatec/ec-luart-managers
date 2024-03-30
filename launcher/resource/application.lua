local application = {}

application.NAME = "ecLauncher"
application.VERSION = "0.1.0"
application.WEBSITE = "https://github.com/esferatec/ec-luart-managers"
application.COPYRIGHT = "(c) 2024"
application.DEVELOPER = "esferatec"
application.SETTINGS = {
  file = sys.File("eclauncher.json"),
  default = {
    LanguageEnglish = true,
    LanguageGerman = false,
  }
}

return application
