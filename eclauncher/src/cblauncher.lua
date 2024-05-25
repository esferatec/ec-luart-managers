local json      = require("json")
local sys       = require("sys")
local sysext    = require("modules.sysextension")
local ui        = require("ui")
local uidialogs = require("modules.uidialogs")

local app       = require("resources.app")
local dic       = require("resources.dic")

local win       = require("uilauncher")

--#region local functions

local function startApplication(application)
  sys.cmd("start " .. application .. ".exe", true, true)
end

local function updateDialogCaption()
  uidialogs.cancelcaption = win.LM:translate("Cancel")
  uidialogs.confirmcaption = win.LM:translate("OK")
end

--#endregion

--#region menu events

function win.MM.children.BurgerEnglish:onClick()
  win.LM.dictionary = dic.english
  win.LM.language = dic.English_United_States
  win.LM:apply()

  updateDialogCaption()

  win.MM:uncheck()
  self.checked = true
end

function win.MM.children.BurgerGerman:onClick()
  win.LM.dictionary = dic.german
  win.LM.language = dic.German_Germany
  win.LM:apply()

  updateDialogCaption()

  win.MM:uncheck()
  self.checked = true
end

function win.MM.children.BurgerSetup:onClick()
  local success, message = nil, nil

  local title = app.TITLE .. " - " .. win.LM:translate("Setup")

  local index = uidialogs.choiceindexdialog(win, title, win.LM:translate("Action"), win.LM:translate("Options"))

  if index == 1 then
    success, message = pcall(sysext.shortcut.create, sysext.specialfolders.startmenu, app.TITLE, app.PATH)
  end

  if index == 2 then
    success, message = pcall(sysext.shortcut.create, sysext.specialfolders.desktop, app.TITLE, app.PATH)
  end

  if index == 3 then
    success, message = pcall(sysext.shortcut.delete, sysext.specialfolders.startmenu, app.TITLE)
  end

  if index == 4 then
    success, message = pcall(sysext.shortcut.delete, sysext.specialfolders.desktop, app.TITLE)
  end

  if index and not success then
    ui.info(message, app.TITLE)
  end
end

function win.MM.children.BurgerHelp:onClick()
  sys.cmd("start " .. app.WEBSITE, true, true)
end

function win.MM.children.BurgerAbout:onClick()
  local message = app.TITLE .. " " .. app.VERSION .. "\n\n"
  message = message .. app.DEVELOPER .. " " .. app.COPYRIGHT .. "\n\n"

  local title = app.TITLE .. " - " .. win.LM:translate("About")

  ui.info(message, title)
end

function win.MM.children.BurgerExit:onClick()
  win:hide()
end

--#endregion

--#region button events

function win.WM.children.ButtonApplication01:onClick()
  startApplication("ecperson")
end

function win.WM.children.ButtonApplication02:onClick()
  startApplication("ectask")
end
--#endregion

--#region window events

function win:onCreate()
  win.title        = app.TITLE
  win.originheight = win.height
  win.originwidth  = win.width

  if app.SETTINGS.file.exists then
    local loaded, settings = pcall(json.load, app.SETTINGS.file)

    if not loaded then
      win.CM.settings = app.SETTINGS.default
    else
      win.CM.settings = settings
    end
  end

  if win.CM.settings == nil or next(win.CM.settings) == nil then
    win.CM.settings = app.SETTINGS.default
  end

  if win.CM:setting("LanguageEnglish") == true then
    win.LM.dictionary = dic.english
    win.LM.language = dic.English_United_States
  end

  if win.CM:setting("LanguageGerman") == true then
    win.LM.dictionary = dic.german
    win.LM.language = dic.German_Germany
  end

  updateDialogCaption()
end

function win:onShow()
  win:center()

  win.GM:apply()
  win.CM:apply()
  win.LM:apply()

  win.WM_DISABLED:disable()
end

function win:onResize()
  if win.height == 0 or win.width == 0 then
    return
  end

  if win.height < win.originheight and win.height > 0 then
    win.height = win.originheight
  end

  if win.width < win.originwidth and win.width > 0 then
    win.width = win.originwidth
  end

  win.GM:update()
end

function win:onKey(key)
  win.KM:apply(key)
end

function win:onHide()
  win.CM:save()

  local saved, message = pcall(json.save, app.SETTINGS.file, win.CM.settings)

  if not saved then
    ui.info(message, app.TITLE)
  end
end

--#endregion

ui.run(win):wait()
