local ui     = require("ui")
local cm     = require("manager.cm") -- configuration manager
local gm     = require("manager.gm") -- geometry manager
local km     = require("manager.km") -- key manager
local lm     = require("manager.lm") -- localization manager
local mm     = require("manager.mm") -- menu manager
local wm     = require("manager.wm") -- widget manager

--#region Window

local Window = ui.Window("ecLauncher", "dialog", 400, 320)
Window.menu  = ui.Menu()
local Menu   = ui.Menu("English", "German", "", "Help", "About", "", "Exit")
Window.menu:add("|||", Menu)

--#endregion

--#region WindowManagers

Window.CM = cm.ConfigurationManager()
Window.GM = gm.GeometryManager():MatrixLayout(Window, 4, 3, gm.RESIZE.Both, 10, 10, 10, 380, 280)
Window.KM = km.KeyManager()
Window.LM = lm.LocalizationManager()
Window.MM = mm.MenuManager()
Window.WM = wm.WidgetManager()
Window.WM_DISABLED = wm.WidgetManager()

--#endregion

--#region ButtonWidgets

local ButtonApplication01 = ui.Button(Window, "1")
local ButtonApplication02 = ui.Button(Window, "2")
local ButtonApplication03 = ui.Button(Window, "3")
local ButtonApplication04 = ui.Button(Window, "4")
local ButtonApplication05 = ui.Button(Window, "5")
local ButtonApplication06 = ui.Button(Window, "6")
local ButtonApplication07 = ui.Button(Window, "7")
local ButtonApplication08 = ui.Button(Window, "8")
local ButtonApplication09 = ui.Button(Window, "9")
local ButtonApplication10 = ui.Button(Window, "10")
local ButtonApplication11 = ui.Button(Window, "11")
local ButtonApplication12 = ui.Button(Window, "12")

--#endregion

--#region WidgetManager

Window.WM:add(ButtonApplication01, "ButtonApplication01")
--Window.WM:add(ButtonApplication02, "ButtonApplication02")
--Window.WM:add(ButtonApplication03, "ButtonApplication03")
--Window.WM:add(ButtonApplication04, "ButtonApplication04")
--Window.WM:add(ButtonApplication05, "ButtonApplication05")
--Window.WM:add(ButtonApplication06, "ButtonApplication06")
--Window.WM:add(ButtonApplication07, "ButtonApplication07")
--Window.WM:add(ButtonApplication08, "ButtonApplication08")
--Window.WM:add(ButtonApplication09, "ButtonApplication09")
--Window.WM:add(ButtonApplication10, "ButtonApplication10")
--Window.WM:add(ButtonApplication11, "ButtonApplication11")
--Window.WM:add(ButtonApplication12, "ButtonApplication12")

Window.WM_DISABLED:add(ButtonApplication02, "ButtonApplication02")
Window.WM_DISABLED:add(ButtonApplication03, "ButtonApplication03")
Window.WM_DISABLED:add(ButtonApplication04, "ButtonApplication04")
Window.WM_DISABLED:add(ButtonApplication05, "ButtonApplication05")
Window.WM_DISABLED:add(ButtonApplication06, "ButtonApplication06")
Window.WM_DISABLED:add(ButtonApplication07, "ButtonApplication07")
Window.WM_DISABLED:add(ButtonApplication08, "ButtonApplication08")
Window.WM_DISABLED:add(ButtonApplication09, "ButtonApplication09")
Window.WM_DISABLED:add(ButtonApplication10, "ButtonApplication10")
Window.WM_DISABLED:add(ButtonApplication11, "ButtonApplication11")
Window.WM_DISABLED:add(ButtonApplication12, "ButtonApplication12")

--#endregion

--#region MenuManager

Window.MM:add(Menu.items[1], "MenuEnglish")
Window.MM:add(Menu.items[2], "MenuGerman")
Window.MM:add(Menu.items[4], "MenuHelp")
Window.MM:add(Menu.items[5], "MenuAbout")
Window.MM:add(Menu.items[7], "MenuExit")

--#endregion

--#region KeyManager

Window.KM:add(ButtonApplication01, "VK_F1")
Window.KM:add(ButtonApplication02, "VK_F2")
Window.KM:add(ButtonApplication03, "VK_F3")
Window.KM:add(ButtonApplication04, "VK_F3")
Window.KM:add(ButtonApplication05, "VK_F5")
Window.KM:add(ButtonApplication06, "VK_F6")
Window.KM:add(ButtonApplication07, "VK_F7")
Window.KM:add(ButtonApplication08, "VK_F8")
Window.KM:add(ButtonApplication09, "VK_F9")
Window.KM:add(ButtonApplication10, "VK_F10")
Window.KM:add(ButtonApplication11, "VK_F11")
Window.KM:add(ButtonApplication12, "VK_F12")

--#endregion

--#region LocalizationManager

Window.LM:add(Menu.items[1], "text", "English")
Window.LM:add(Menu.items[2], "text", "German")
Window.LM:add(Menu.items[4], "text", "Help")
Window.LM:add(Menu.items[5], "text", "About")
Window.LM:add(Menu.items[7], "text", "Exit")

Window.LM:add(ButtonApplication01, "text", "Application01")
Window.LM:add(ButtonApplication02, "text", "Application02")
Window.LM:add(ButtonApplication03, "text", "Application03")
Window.LM:add(ButtonApplication04, "text", "Application04")
Window.LM:add(ButtonApplication05, "text", "Application05")
Window.LM:add(ButtonApplication06, "text", "Application06")
Window.LM:add(ButtonApplication07, "text", "Application07")
Window.LM:add(ButtonApplication08, "text", "Application08")
Window.LM:add(ButtonApplication09, "text", "Application09")
Window.LM:add(ButtonApplication10, "text", "Application10")
Window.LM:add(ButtonApplication11, "text", "Application11")
Window.LM:add(ButtonApplication12, "text", "Application12")

--endregion

--#region GeometryManager:

Window.GM:add(ButtonApplication01)
Window.GM:add(ButtonApplication02)
Window.GM:add(ButtonApplication03)
Window.GM:add(ButtonApplication04)
Window.GM:add(ButtonApplication05)
Window.GM:add(ButtonApplication06)
Window.GM:add(ButtonApplication07)
Window.GM:add(ButtonApplication08)
Window.GM:add(ButtonApplication09)
Window.GM:add(ButtonApplication10)
Window.GM:add(ButtonApplication11)
Window.GM:add(ButtonApplication12)

--#endregion

--#region ConfigurationManager

Window.CM:add(Menu.items[1], "checked", "LanguageEnglish")
Window.CM:add(Menu.items[2], "checked", "LanguageGerman")

--#endregion

return Window
