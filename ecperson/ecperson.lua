require("common.extension")

local ui = require("ui")
local sys = require("sys")
local json = require("json")

local db = require("resource.person")
local app = require("resource.application")

app.FOLDER = sys.File(arg[-1]).path
app.DATABSEFILE = arg[1]
app.SETTINGFILE = sys.File(app.FOLDER .. "\\ecperson.json")

if app.DATABSEFILE ~= nil and string.find(app.DATABSEFILE, ".person") == nil then
  ui.error("This file type ist not supported.", app.NAME)
  sys.exit()
end

if app.DATABSEFILE == nil then
  local newDatabase = ui.savedialog("", false, "Person (*.person)|*.person")

  if newDatabase == nil then
    ui.info("")
    sys.exit()
  end

  if newDatabase ~= nil then
    db:save(newDatabase.fullpath)
  end
end

--if not SETTINGFILE.exists then
--  local default = {
--    MenuAPPLICATIONEnglish = true,
--    MenuAPPLICATIONGerman = false,
--    MenuSortSequenceASC = true,
--    MenuShowAllTasks = true
--  }

-- local success, message = pcall(json.save, SETTINGFILE, default)

-- if not success then
--   ui.info(message, APPLICATION)
-- end
--end

--dofile(embed.File("cbmain.lua").fullpath)
dofile("cbmain.lua")

if sys.error then
  ui.error(sys.error, app.NAME)
end

sys.exit()
