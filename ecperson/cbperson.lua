require("common.extension")

local json         = require("json")
local sys          = require("sys")
local sysextension = require("modules.sysextension")
local ui           = require("ui")
local uidialogs    = require("modules.uidialogs")

local app          = require("resources.app")
local dic          = require("resources.dic")

--#region win initialization OK

local win          = require("uiperson")
win:center()
win:status()

--#endregion

--#region db initialization OK

local db = require("dbperson")
db:create()

--#endregion

--#region local functions OK

local function updateDialogCaption()
  uidialogs.cancelcaption = win.LM:translate("Cancel")
  uidialogs.confirmcaption = win.LM:translate("OK")
end

--#endregion

--#region window methods

function win:updatetitle()
  self.title = app.NAME .. " - " .. app.DATABASE.name
end

function win:updatestatus()
  if db.record then
    local t = win.DM.key or "#"
    self:status(db.record .. " / " .. db.total .. " - " .. t)
  end
end

function win:updatewidget()
  if not db.record then
    win.WM_ZERO:disable()
  else
    win.WM_ZERO:enable()
  end
end

--#endregion

--#region menu events OK

function win.MM.children.BurgerEnglish:onClick()
  win.LM.dictionary = dic.english
  win.LM.language = dic.English_United_States
  win.LM:apply()

  updateDialogCaption()

  win.MM:uncheck()
  self.checked = true

  win.WM:focus("EntryLastName")
end

function win.MM.children.BurgerGerman:onClick()
  win.LM.dictionary = dic.german
  win.LM.language = dic.German_Germany
  win.LM:apply()

  updateDialogCaption()

  win.MM:uncheck()
  self.checked = true

  win.WM:focus("EntryLastName")
end

function win.MM.children.BurgerSetup:onClick()
  local success, message = nil, nil

  local title = app.TITLE .. " - " .. win.LM:translate("Setup")

  local index = uidialogs.choiceindexdialog(win, title, win.LM:translate("Action"), win.LM:translate("Options"))

  if index == 1 then
    success, message = pcall(sysextension.shortcut.create, sysextension.specialfolders.startmenu, app.TITLE, app.PATH)
  end

  if index == 2 then
    success, message = pcall(sysextension.shortcut.create, sysextension.specialfolders.desktop, app.TITLE, app.PATH)
  end

  if index == 3 then
    success, message = pcall(sysextension.shortcut.delete, sysextension.specialfolders.startmenu, app.TITLE)
  end

  if index == 4 then
    success, message = pcall(sysextension.shortcut.delete, sysextension.specialfolders.desktop, app.TITLE)
  end

  if index and not success then
    ui.info(message, app.TITLE)
  end
end

function win.MM.children.BurgerHelp:onClick()
  sys.cmd("start " .. app.WEBSITE, true, true)
end

function win.MM.children.BurgerAbout:onClick()
  local message = app.NAME .. " " .. app.VERSION .. "\n\n"
  message = message .. app.DEVELOPER .. " " .. app.COPYRIGHT .. "\n\n"

  local title = app.NAME .. " - " .. win.LM:translate("About")

  ui.info(message, title)
end

function win.MM.children.BurgerExit:onClick()
  win:hide()
end

--#endregion

--#region button events

function win.WM.children.ButtonFirst:onClick()
  if not db.record then return end

  db.record = 1
  win.DM:select(db, db.table, db.record - 1)

  win:updatestatus()
end

function win.WM.children.ButtonPrevious:onClick()
  if not db.record then return end
  if db.record <= 1 then return end

  db.record = db.record - 1
  win.DM:select(db, db.table, db.record - 1)

  win:updatestatus()
end

function win.WM.children.ButtonFilter:onClick()
  ui.info("ok")
end

function win.WM.children.ButtonNext:onClick()
  if not db.record then return end
  if db.record >= db.total then return end

  db.record = db.record + 1
  win.DM:select(db, db.table, db.record - 1)

  win:updatestatus()
end

function win.WM.children.ButtonLast:onClick()
  if not db.record then return end

  db.record = db.total
  win.DM:select(db, "tbl_person", db.record - 1)

  win:updatestatus()
end

function win.WM.children.ButtonNew:onClick()
  db.record = nil
  win.DM:clear()

  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonSave:onClick()
  win.VM:apply()

  if win.VM.isvalid then
    win.DM:apply()
    win.DM:insert(db, db.table)
    win.DM:selectlast(db, db.table)

  else
    local errorText = ""

    for _, text in ipairs(win.VM.message) do
      errorText = errorText .. win.LM:translate(text) .. "\n"
    end

    ui.warn(errorText, app.NAME .. " - " .. win.LM:translate("Warning"))
  end

    db.record = db:count()
    db.total = db.record

    win:updatestatus()
    win:updatewidget()

end

function win.WM.children.ButtonDelete:onClick()
  if not db.record then return end

  win.DM:delete(db, db.table)
  --win.DM:update(db, db.table)

  db.record = 2
  win.DM.key = 2
  win.DM:selectone(db, db.table)

  win:updatestatus()
  win:updatewidget()
end

--[[


function win.WM.children.ButtonSave:onClick()
  win.VM:apply()

  if win.VM.isvalid then
    --db:insert(win.WM_ENTRY.children.EntryTask.text)
  else
    local errorText = ""

    for _, text in ipairs(win.VM.message) do
      errorText = errorText .. win.LM:translate(text) .. "\n"
    end

    ui.warn(errorText, application.NAME .. " - " .. win.LM:translate("Warning"))
  end
end

function win.WM.children.ButtonDelete:onClick()
  --win.DM:apply()
  win.DM:update(db, "tbl_person", 5)
end

--]]

--#endregion

--#region window events

function win:onCreate()
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
  win.GM_NAME_LABEL:apply()
  win.GM_NAME_ENTRY:apply()
  win.GM_LOCATION_LABEL:apply()
  win.GM_LOCATION_ENTRY:apply()
  win.GM_CONTACT:apply()
  win.GM_NOTE:apply()
  win.GM_MENU:apply()
  win.CM:apply()
  win.LM:apply()

  win:updatetitle()
  win:updatestatus()
  win:updatewidget()

  win.WM:focus("EntryLastName")
end

function win:onKey(key)
  win.KM:apply(key)
end

function win:onHide()
  win.CM:update("LanguageEnglish", win.MM.children.BurgerEnglish.checked)
  win.CM:update("LanguageGerman", win.MM.children.BurgerGerman.checked)

  local saved, message = pcall(json.save, app.SETTINGS.file, win.CM.settings)

  if not saved then
    ui.info(message, app.TITLE)
  end
end

--#endregion

ui.run(win):wait()
