local json   = require("json")
local sys    = require("sys")
local ui     = require("ui")
local sqlite = require("sqlite")

local app    = require("resources.app")

if app.ARGUMENT == nil then
  local selected = ui.savedialog("Create ecPerson File", false, "ecPerson file (*.ecperson)|*.ecperson")

  if not selected then
    sys.exit()
  end

  if selected.exists then
    ui.info("This file already exists", app.NAME)
    sys.exit()
  end

  local database = sqlite.Database(selected)
  app.ARGUMENT = database.file.fullpath
  sqlite.Database.close(database)
end

if app.ARGUMENT ~= nil then
  if not string.find(app.ARGUMENT, app.DATABASE.type) then
    ui.error("This file type is not supported.", app.NAME)
    sys.exit()
  end

  app.DATABASE.fullpath = app.ARGUMENT
end

if not app.SETTINGS.file.exists then
  local saved, message = pcall(json.save, app.SETTINGS.file, app.SETTINGS.default)

  if not saved then
    ui.info(message, app.NAME)
  end
end

dofile(embed and embed.File("cbperson.lua").fullpath or "cbperson.lua")
