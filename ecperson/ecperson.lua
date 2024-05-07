local json   = require("json")
local sys    = require("sys")
local ui     = require("ui")
local sqlite = require("sqlite")

local app    = require("resources.app")

if not app.ARGUMENT then
  local file = ui.savedialog("Create ecPerson File", false, "ecPerson file (*.ecperson)|*.ecperson")

  if not file then
    sys.exit()
  end

  if file.exists then
    app.ARGUMENT = file.fullpath
  else
    local database = sqlite.Database(file)
    app.ARGUMENT = database.file.fullpath
    sqlite.Database.close(database)
  end
end

if app.ARGUMENT then
  if not string.find(app.ARGUMENT, app.DATABASE.type) then
    ui.error("This file type is not supported.", app.NAME)
    sys.exit()
  end

  app.DATABASE.name = app.ARGUMENT -- in fullpath umbennene analog file
end

if not app.SETTINGS.file.exists then
  local saved, message = pcall(json.save, app.SETTINGS.file, app.SETTINGS.default)

  if not saved then
    ui.info(message, app.NAME)
  end
end

dofile(embed and embed.File("cbperson.lua").fullpath or "cbperson.lua")

if sys.error then
  ui.error(sys.error, app.NAME)
end

sys.exit()
