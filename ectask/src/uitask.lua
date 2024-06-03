require("common.extension")

local ui = require("ui")
local uiextension = require("modules.uiextension")

local cm = require("managers.cm") -- configuration manager
local dm = require("managers.dm") -- data manager
local gm = require("managers.gm") -- geometry manager
local km = require("managers.km") -- key manager
local lm = require("managers.lm") -- localization manager
local mm = require("managers.mm") -- menu manager
local vm = require("managers.vm") -- validation manager
local wm = require("managers.wm") -- widget manager

--#region Functions

local function isRequired(value)
  value = string.trim(value)
  return not string.isnil(value) and not string.isempty(value)
end

--#endregion

--#region Menu

local MenuBurger = ui.Menu("English", "German", "", "Setup", "Help", "About", "", "Exit")

--#endregion

--#region Window

local Window     = ui.Window("ecTask", "single", 710, 553)
Window.menu      = ui.Menu()
Window.menu:add("|||", MenuBurger)

--#endregion

--#region Managers

Window.CM            = cm.ConfigurationManager()
Window.DM            = dm.DataManager()
Window.GM_NOTE       = gm.GeometryManager():RowLayout(Window, gm.DIRECTION.Left, 0, 30, 352, 650, 80)
Window.GM_TASKS      = gm.GeometryManager():RowLayout(Window, gm.DIRECTION.Left, 16, 30, 58, 650, 274)
Window.GM_TOOL       = gm.GeometryManager():RowLayout(Window, gm.DIRECTION.left, 8, 29, 452, 650, 34)
Window.KM            = km.KeyManager()
Window.LM            = lm.LocalizationManager()
Window.MM            = mm.MenuManager()
Window.VM            = vm.ValidationManager()
Window.WM            = wm.WidgetManager()
Window.WM_ZERO       = wm.WidgetManager()

--#endregion

--#region Widgets

local LabelSubject   = ui.Label(Window, "Subject", 30, 18, 80, 20)
local EntrySubject   = ui.Entry(Window, "", 120, 14, 560, 24)

local ColumnTasks1   = uiextension.ColumnPanel(Window, uiextension.StrikeEntry, 10, 6, 0, 0, 317, 274)
local ColumnTasks2   = uiextension.ColumnPanel(Window, uiextension.StrikeEntry, 10, 6, 0, 0, 317, 274)

local EditNote       = ui.Edit(Window, "", 0, 0, 648, 80)

local ButtonFirst    = ui.Button(Window, "|<", 0, 0, 55, 34)
local ButtonPrevious = ui.Button(Window, "<", 0, 0, 55, 34)
local ButtonGoto     = ui.Button(Window, "(   )", 0, 0, 67, 34)
local ButtonNext     = ui.Button(Window, ">", 0, 0, 55, 34)
local ButtonLast     = ui.Button(Window, ">|", 0, 0, 55, 34)
local ButtonNew      = ui.Button(Window, "New", 0, 0, 75, 34)
local ButtonSave     = ui.Button(Window, "Save", 0, 0, 75, 34)
local ButtonCancel   = ui.Button(Window, "Cancel", 0, 0, 75, 34)
local ButtonDelete   = ui.Button(Window, "Delete", 0, 0, 75, 34)

--#endregion

--#region WidgetManager

Window.WM:add(EntrySubject, "EntrySubject")
Window.WM:add(ColumnTasks1, "ColumnTasks1")
Window.WM:add(ColumnTasks2, "ColumnTasks2")
Window.WM:add(EditNote, "EditNote")
Window.WM:add(ButtonFirst, "ButtonFirst")
Window.WM:add(ButtonPrevious, "ButtonPrevious")
Window.WM:add(ButtonGoto, "ButtonGoto")
Window.WM:add(ButtonNext, "ButtonNext")
Window.WM:add(ButtonLast, "ButtonLast")
Window.WM:add(ButtonNew, "ButtonNew")
Window.WM:add(ButtonSave, "ButtonSave")
Window.WM:add(ButtonCancel, "ButtonCancel")
Window.WM:add(ButtonDelete, "ButtonDelete")

--#endregion

--#region WidgetManager ZERO

Window.WM_ZERO:add(ButtonFirst, "ButtonFirst")
Window.WM_ZERO:add(ButtonPrevious, "ButtonPrevious")
Window.WM_ZERO:add(ButtonGoto, "ButtonGoto")
Window.WM_ZERO:add(ButtonNext, "ButtonNext")
Window.WM_ZERO:add(ButtonLast, "ButtonLast")
Window.WM_ZERO:add(ButtonNew, "ButtonNew")
Window.WM_ZERO:add(ButtonDelete, "ButtonDelete")

--#endregion

--#region MenuManager

Window.MM:add(MenuBurger.items[1], "BurgerEnglish")
Window.MM:add(MenuBurger.items[2], "BurgerGerman")
Window.MM:add(MenuBurger.items[4], "BurgerSetup")
Window.MM:add(MenuBurger.items[5], "BurgerHelp")
Window.MM:add(MenuBurger.items[6], "BurgerAbout")
Window.MM:add(MenuBurger.items[8], "BurgerExit")

--#endregion

--#region KeyManager

Window.KM:add(ButtonFirst, "VK_HOME")
Window.KM:add(ButtonPrevious, "VK_PRIOR")
Window.KM:add(ButtonGoto, "VK_F2")
Window.KM:add(ButtonNext, "VK_NEXT")
Window.KM:add(ButtonLast, "VK_END")
Window.KM:add(ButtonNew, "VK_F3")
Window.KM:add(ButtonSave, "VK_F4")
Window.KM:add(ButtonCancel, "VK_F5")
Window.KM:add(ButtonDelete, "VK_F6")

--#endregion

--#region LocalizationManager

Window.LM:add(MenuBurger.items[1], "text", "English")
Window.LM:add(MenuBurger.items[2], "text", "German")
Window.LM:add(MenuBurger.items[4], "text", "Setup")
Window.LM:add(MenuBurger.items[5], "text", "Help")
Window.LM:add(MenuBurger.items[6], "text", "About")
Window.LM:add(MenuBurger.items[7], "text", "Exit")

Window.LM:add(LabelSubject, "text", "Subject")

Window.LM:add(ButtonFirst, "tooltip", "FirstRecord")
Window.LM:add(ButtonPrevious, "tooltip", "PreviousRecord")
Window.LM:add(ButtonGoto, "tooltip", "GotoRecord")
Window.LM:add(ButtonNext, "tooltip", "NextRecord")
Window.LM:add(ButtonLast, "tooltip", "LastRecord")
Window.LM:add(ButtonNew, "tooltip", "NewRecord")
Window.LM:add(ButtonSave, "tooltip", "SaveRecord")
Window.LM:add(ButtonCancel, "tooltip", "CancelRecord")
Window.LM:add(ButtonDelete, "tooltip", "DeleteRecord")

Window.LM:add(ButtonNew, "text", "New")
Window.LM:add(ButtonSave, "text", "Save")
Window.LM:add(ButtonDelete, "text", "Delete")
Window.LM:add(ButtonCancel, "text", "Cancel")

--endregion

--#region GeometryManager: TASKS

Window.GM_TASKS:add(ColumnTasks1)
Window.GM_TASKS:add(ColumnTasks2)

--#endregion

--#region GeometryManager: NOTE

Window.GM_NOTE:add(EditNote)

--#endregion

--#region GeometryManager: TOOL

Window.GM_TOOL:add(ButtonFirst)
Window.GM_TOOL:add(ButtonPrevious)
Window.GM_TOOL:add(ButtonGoto)
Window.GM_TOOL:add(ButtonNext)
Window.GM_TOOL:add(ButtonLast)
Window.GM_TOOL:add(ButtonNew)
Window.GM_TOOL:add(ButtonSave)
Window.GM_TOOL:add(ButtonCancel)
Window.GM_TOOL:add(ButtonDelete)

--#endregion

--#region ConfigurationManager

Window.CM:add(MenuBurger.items[1], "checked", "LanguageEnglish")
Window.CM:add(MenuBurger.items[2], "checked", "LanguageGerman")

--#endregion

--#region ValidationManager

Window.VM:add(EntrySubject, "text", isRequired, "SubjectRequired")

--#endregion

--#region DataManager

Window.DM:add("subject", EntrySubject, "text", "")
Window.DM:add("note", EditNote, "text", "")

--#endregion

--#region Events

function ColumnTasks1:onCreate()
  super(self).onCreate(self)

  Window.DM:add("task01", ColumnTasks1.items[1], "text", "")
  Window.DM:add("task02", ColumnTasks1.items[2], "text", "")
  Window.DM:add("task03", ColumnTasks1.items[3], "text", "")
  Window.DM:add("task04", ColumnTasks1.items[4], "text", "")
  Window.DM:add("task05", ColumnTasks1.items[5], "text", "")
  Window.DM:add("task06", ColumnTasks1.items[6], "text", "")
  Window.DM:add("task07", ColumnTasks1.items[7], "text", "")
  Window.DM:add("task08", ColumnTasks1.items[8], "text", "")
  Window.DM:add("task09", ColumnTasks1.items[9], "text", "")
  Window.DM:add("task10", ColumnTasks1.items[10], "text", "")

  Window.DM:add("done01", ColumnTasks1.items[1], "checked", false)
  Window.DM:add("done02", ColumnTasks1.items[2], "checked", false)
  Window.DM:add("done03", ColumnTasks1.items[3], "checked", false)
  Window.DM:add("done04", ColumnTasks1.items[4], "checked", false)
  Window.DM:add("done05", ColumnTasks1.items[5], "checked", false)
  Window.DM:add("done06", ColumnTasks1.items[6], "checked", false)
  Window.DM:add("done07", ColumnTasks1.items[7], "checked", false)
  Window.DM:add("done08", ColumnTasks1.items[8], "checked", false)
  Window.DM:add("done09", ColumnTasks1.items[9], "checked", false)
  Window.DM:add("done10", ColumnTasks1.items[10], "checked", false)
end

function ColumnTasks2:onCreate()
  super(self).onCreate(self)

  Window.DM:add("task11", ColumnTasks2.items[1], "text", "")
  Window.DM:add("task12", ColumnTasks2.items[2], "text", "")
  Window.DM:add("task13", ColumnTasks2.items[3], "text", "")
  Window.DM:add("task14", ColumnTasks2.items[4], "text", "")
  Window.DM:add("task15", ColumnTasks2.items[5], "text", "")
  Window.DM:add("task16", ColumnTasks2.items[6], "text", "")
  Window.DM:add("task17", ColumnTasks2.items[7], "text", "")
  Window.DM:add("task18", ColumnTasks2.items[8], "text", "")
  Window.DM:add("task19", ColumnTasks2.items[9], "text", "")
  Window.DM:add("task20", ColumnTasks2.items[10], "text", "")

  Window.DM:add("done11", ColumnTasks2.items[1], "checked", false)
  Window.DM:add("done12", ColumnTasks2.items[2], "checked", false)
  Window.DM:add("done13", ColumnTasks2.items[3], "checked", false)
  Window.DM:add("done14", ColumnTasks2.items[4], "checked", false)
  Window.DM:add("done15", ColumnTasks2.items[5], "checked", false)
  Window.DM:add("done16", ColumnTasks2.items[6], "checked", false)
  Window.DM:add("done17", ColumnTasks2.items[7], "checked", false)
  Window.DM:add("done18", ColumnTasks2.items[8], "checked", false)
  Window.DM:add("done19", ColumnTasks2.items[9], "checked", false)
  Window.DM:add("done20", ColumnTasks2.items[10], "checked", false)
end

--#endregion

return Window
