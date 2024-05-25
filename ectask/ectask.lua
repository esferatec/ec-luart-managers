local json   = require("json")
local sqlite = require("sqlite")
local sys    = require("sys")
local ui     = require("ui")

local app    = require("resources.app")

if app.ARGUMENT == nil then
  local selected = ui.savedialog("Create ecTask File", false, "ecTask file (*.ectask)|*.ectask")

  if not selected then
    sys.exit()
  end

  if selected.exists then
    ui.info("This file already exists.", app.NAME)
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

dofile(embed and embed.File("cbtask.lua").fullpath or "cbtask.lua")

if sys.error then
  ui.error(sys.error, app.NAME)
end

sys.exit()
