require("common.extension")

local json         = require("json")
local sys          = require("sys")
local sysextension = require("modules.sysextension")
local ui           = require("ui")
local uidialogs    = require("modules.uidialogs")

local app          = require("resources.app")
local dic          = require("resources.dic")

--#region win initialization

local win          = require("uiperson")
win:center()
win:status()

--#endregion

--#region db initialization

local db = require("dbperson")
db:create()

--#endregion

--#region local functions

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
  self:status(" ")

  if db.record then
    local text = string.format(win.LM:translate("statustext"), db.record, db.total)
    self:status(text)
  end
end

function win:updatewidget()
  if not db.record then
    win.WM_ZERO:disable()
  else
    win.WM_ZERO:enable()
  end

  win.WM:focus("EntryLastName")
end

function win:updatedata() -- optimierung bei new, save, cancel
  if db.total == 0 or db.record == nil then
    db.record = nil
    win.DM:clear()
    return
  end

  if db.total ~= 0 and db.record ~= nil then
    win.DM:select(db, db.table, db.record - 1)
    return
  end
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

  win:updatestatus()
end

function win.MM.children.BurgerGerman:onClick()
  win.LM.dictionary = dic.german
  win.LM.language = dic.German_Germany
  win.LM:apply()

  updateDialogCaption()

  win.MM:uncheck()
  self.checked = true

  win:updatestatus()
end

function win.MM.children.BurgerSetup:onClick()
  local success, message = nil, nil

  local title = app.NAME .. " - " .. win.LM:translate("Setup")

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
    ui.info(message, app.NAME)
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

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonPrevious:onClick()
  if not db.record then return end
  if db.record <= 1 then return end

  db.record = db.record - 1

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonFilter:onClick()
  if not db.record then return end

  local items = db:list()

  local title = app.NAME .. " - " .. win.LM:translate("Goto")

  local index = uidialogs.choiceindexdialog(win, title, win.LM:translate("Action"), items, nil, 400)

  if index then
    db.record = index

    win:updatedata()
    win:updatestatus()
  end
end

function win.WM.children.ButtonNext:onClick()
  if not db.record then return end
  if db.record >= db.total then return end

  db.record = db.record + 1

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonLast:onClick()
  if not db.record then return end

  db.record = db.total

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonNew:onClick()
  if not db.record then return end

  db.record = nil

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonSave:onClick()
  win.VM:apply()

  if not win.VM.isvalid then
    local message = ""

    for _, text in ipairs(win.VM.message) do
      message = message .. win.LM:translate(text) .. "\n"
    end

    ui.warn(message, app.NAME .. " - " .. win.LM:translate("Warning"))
    return
  end

  if win.DM.key == -1 then
    win.DM:insert(db, db.table)

    db.total = db:count()
    db.record = (db.total ~= 0 and db.total) or nil
  else
    win.DM:update(db, db.table)
  end

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonCancel:onClick() -- überprüfen?
  if win.DM.key == -1 then
    db.record = 1
  end

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonDelete:onClick()
  if not db.record then return end

  win.DM:delete(db, db.table)

  db.total = db:count()
  db.record = (db.total ~= 0 and 1) or nil

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

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
  win.GM_TOOL:apply()
  win.CM:apply()
  win.LM:apply()

  db.total = db:count()
  db.record = (db.total ~= 0 and 1) or nil

  win:updatedata()
  win:updatetitle()
  win:updatestatus()
  win:updatewidget()
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
