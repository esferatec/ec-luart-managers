local ui   = require("ui")
local sys  = require("sys")
local json = require("json")

local app  = require("resources.app")

if not app.SETTINGS.file.exists then
  local saved, message = pcall(json.save, app.SETTINGS.file, app.SETTINGS.default)

  if not saved then
    ui.info(message, app.TITLE)
  end
end

dofile(embed and embed.File("cblauncher.lua").fullpath or "cblauncher.lua")

if sys.error then
  ui.error(sys.error, app.TITLE)
end

sys.exit()
