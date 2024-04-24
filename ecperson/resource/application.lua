require("common.extension")

--local sys = require("sys")

local Application = Object({})

Application.NAME = "ecPerson"
Application.VERSION = "0.1.0"
Application.WEBSITE = "https://github.com/esferatec/???"
Application.COPYRIGHT = "(c) 2024"
Application.DEVELOPER = "esferatec"
Application.FOLDER = nil
Application.DATABSEFILE = nil
Application.SETTINGFILE = nil

--[[
application.SETTINGS = {
  file = sys.File("ectasks.json"),
  default = {
    MenuAppEnglish = true,
    MenuAppGerman = false,
    MenuSortSequenceASC = true,
    MenuShowAllTasks = true
  }
}
]]--

return Application