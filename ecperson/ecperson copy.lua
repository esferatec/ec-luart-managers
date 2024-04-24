require("common.extension")

local ui = require("ui")
local sys = require("sys")
local json = require("json")
local db = require("resource.person")

local APPLICATION = "Person"
local FOLDER = sys.File(arg[-1]).path
local ARG = arg[1]
local ROOT = "HKEY_CURRENT_USER"
local KEY = "Software\\Classes\\"
local SUFFIX = "ecperson"
local EXE = "\\ecperson.exe"
local ICON = "ecperson\\DefaultIcon"
local COMMAND = "ectask\\shell\\open\\command"
local SETTING = sys.File(FOLDER .. "\\ectasks.json")

local function removeFileTypeAssociation()
  sys.registry.delete(ROOT, KEY .. "." .. SUFFIX)
  sys.registry.delete(ROOT, KEY .. SUFFIX)
  sys.registry.delete(ROOT, KEY .. ICON)
  sys.registry.delete(ROOT, KEY .. COMMAND)
end

local function addFileTypeAssociation()
  sys.registry.write(ROOT, KEY .. "." .. SUFFIX, nil, SUFFIX)
  sys.registry.write(ROOT, KEY .. SUFFIX, nil, SUFFIX)
  sys.registry.write(ROOT, KEY .. ICON, nil, FOLDER .. EXE .. ",0")
  sys.registry.write(ROOT, KEY .. COMMAND, nil, '"' .. FOLDER .. EXE .. '" "%1"')
end

if ARG == "uninstall" or ARG == "install" then
  if ARG == "uninstall" then
    if ui.confirm("Do you want to remove the file type association from the registry?", APPLICATION) == "yes" then
      removeFileTypeAssociation()
      ui.info("File type association removed from the registry.", APPLICATION)
    end

    sys.exit()
  end

  if ARG == "install" then
    if ui.confirm("Do you want to add the file type association to the registry?", APPLICATION) == "yes" then
      addFileTypeAssociation()
      ui.info("File type association added to the registry.", APPLICATION)
    end

    sys.exit()
  end
end

if ARG ~= nil and string.find(ARG, ".ectask") == nil then
  ui.error("This file type ist not supported.", APPLICATION)
  sys.exit()
end

if ARG == nil then
  local saveFile = ui.savedialog("", false, "Person (*.person)|*.person")

  if saveFile ~= nil then
    db:save(saveFile.fullpath)
  end
end

if not SETTING.exists then
  local defaultSettings = {
    MenuAPPLICATIONEnglish = true,
    MenuAPPLICATIONGerman = false,
    MenuSortSequenceASC = true,
    MenuShowAllTasks = true
  }

  local success, message = pcall(json.save, SETTING, defaultSettings)

  if not success then
    ui.info(message, APPLICATION)
  end
end

--dofile(embed.File("cbmain.lua").fullpath)

if sys.error then
  ui.error(sys.error, APPLICATION)
end

sys.exit()
