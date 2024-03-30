local ui   = require("ui")
local sys  = require("sys")
local json = require("json")

local dic  = require("resource.dictionary")
local app  = require("resource.application")

local win  = require("uilauncher")

--#region local functions

local function startApplicationNewFile(application)
  sys.cmd("start " .. application, true, true)
end

local function startApplicationOpenFile(application)
  local file = ui.opendialog()

  if file then
    sys.cmd("start " .. application .. ".exe " .. file.fullpath, true, true)
  end
end

--#endregion

--#region menu events

function win.MM.children.MenuEnglish:onClick()
  win.LM.dictionary = dic.english
  win.LM.language = dic.English_United_States
  win.LM:apply()

  win.MM:uncheck()
  self.checked = true
end

function win.MM.children.MenuGerman:onClick()
  win.LM.dictionary = dic.german
  win.LM.language = dic.German_Germany
  win.LM:apply()

  win.MM:uncheck()
  self.checked = true
end

function win.MM.children.MenuHelp:onClick()
  sys.cmd("start " .. app.WEBSITE, true, true)
end

function win.MM.children.MenuAbout:onClick()
  local message = app.NAME .. " " .. app.VERSION .. "\n\n"
  message = message .. app.DEVELOPER .. " " .. app.COPYRIGHT .. "\n\n"
  message = message .. app.WEBSITE

  local title = app.NAME .. " - " .. win.LM:translate("About")

  ui.info(message, title)
end

function win.MM.children.MenuExit:onClick()
  win:hide()
end

--#endregion

--#region button events

function win.WM.children.ButtonApplication01:onClick()
  startApplicationNewFile("ecperson")
end

function win.WM.children.ButtonApplication01:onContext()
  startApplicationOpenFile("ecperson")
end

--#endregion

--#region window events

function win:onCreate()
  win.title        = app.NAME
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

function win:onClose()
  win.CM:update("LanguageEnglish", win.MM.children.MenuEnglish.checked)
  win.CM:update("LanguageGerman", win.MM.children.MenuGerman.checked)

  if not pcall(json.save, app.SETTINGS.file, win.CM.settings) then
    sys.exit()
  end
end

--#endregion

ui.run(win):wait()
