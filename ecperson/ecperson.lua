local ui   = require("ui")
local sys  = require("sys")
local json = require("json")

local app  = require("resources.app")

if not app.SETTINGS.file.exists then
  local saved, message = pcall(json.save, app.SETTINGS.file, app.SETTINGS.default)

  if not saved then
    ui.info(message, app.NAME)
  end
end

if app.ARGUMENT then
  if not string.find(app.ARGUMENT, app.DATABASE.type) then
    ui.error("This file type is not supported.", app.NAME)
    sys.exit()
  end
end

dofile(embed and embed.File("cbperson.lua").fullpath or "cbperson.lua")

if sys.error then
  ui.error(sys.error, app.NAME)
end

sys.exit()
