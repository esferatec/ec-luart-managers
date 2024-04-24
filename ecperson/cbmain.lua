require("common.extension")

local ui           = require("ui")
local json         = require("json")

local application  = require("resource.application")

local translations = require("resource.translations")

--#region db initialization

--local db           = database.Person("gg.db") --(arg[1] == nil) and database.Person(":memory:") or database.Person(arg[1])

--db:create()
--b:insert("mmmmmmm")




--#endregion

--#region win initialization

local win = require("uimain")
local db     = require("resource.person")
db.record = 1
db.current = nil


--#endregion

--win.DM:apply()

--win.DM:insert(db, "tbl_person")
--win.DM:insert(db, "tbl_person")
--win.DM:insert(db, "tbl_person")
--win.DM:insert(db, "tbl_person")

--win.DM:delete(db, 1)



--#region menu events

function win.MM.children.MenuEnglish:onClick()
  win.LM.dictionary = translations.english
  win.LM.language = translations.English_United_States
  win.LM:apply()

  win.MM:uncheck()
  self.checked = true

  win.WM:focus("EntryLastName")
end

function win.MM.children.MenuGerman:onClick()
  win.LM.dictionary = translations.german
  win.LM.language = translations.German_Germany
  win.LM:apply()

  win.MM:uncheck()
  self.checked = true

  win.WM:focus("EntryLastName")
end

function win.MM.children.MenuHelp:onClick()
  ui.info(db:countall())
end

function win.MM.children.MenuAbout:onClick()
  local aboutText = application.NAME .. " " .. application.VERSION .. "\n\n"
  aboutText = aboutText .. application.DEVELOPER .. " " .. application.COPYRIGHT .. "\n\n"
  aboutText = aboutText .. application.WEBSITE

  ui.info(aboutText, application.NAME .. " - " .. win.LM:translate("About"))
end

function win.MM.children.MenuExit:onClick()
  ui.info("mmmm")
end

--#endregion

--#region button events

function win.WM.children.ButtonFirst:onClick()
  db.record = 0
  win.DM:select(db, "tbl_person", db.record)
  win:status(db.record + 1 .. db.current)
end

function win.WM.children.ButtonPrevious:onClick()
  if db.record <= 0 then return end

  db.record = db.record - 1
  win.DM:select(db, "tbl_person", db.record)
  win:status(db.record + 1 .. db.current)
end

function win.WM.children.ButtonFilter:onClick()
  ui.info("ok")
end

function win.WM.children.ButtonNext:onClick()
  if db.record >= db:countall()-1 then return end

  db.record = db.record + 1
  win.DM:select(db, "tbl_person", db.record)
  win:status(db.record + 1 .. db.current)
end

function win.WM.children.ButtonLast:onClick()
  db.record = db:countall()-1
  win.DM:select(db, "tbl_person", db.record)
  win:status(db.record + 1 .. db.current)
end

function win.WM.children.ButtonNew:onClick()
  win.DM:apply()
  win.DM:insert(db, "tbl_person")

end

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

function win.WM.children.ButtonCancel:onClick()
  win.DM:delete(db, "tbl_person")
end

--#endregion

--#region window events

function win:onCreate()
  win:center()
  win:status()

  win.title = application.NAME

  win.GM_NAME_LABEL:apply()
  win.GM_NAME_ENTRY:apply()
  win.GM_LOCATION_LABEL:apply()
  win.GM_LOCATION_ENTRY:apply()
  win.GM_CONTACT:apply()
  win.GM_NOTE:apply()
  win.GM_MENU:apply()
end

function win:onShow()
  win.WM:focus("EntryLastName")
end

function win:onResize()
  win.WM:focus("EntryLastName")
end

function win:onKey(key)
  win.KM:apply(key)
end

--#endregion

ui.info(application.FOLDER)

ui.run(win):wait()
