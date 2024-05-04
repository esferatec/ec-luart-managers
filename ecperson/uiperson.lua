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
  return value ~= nil and string.trim(value) ~= ""
end

--#endregion

--#region Menu

local MenuBurger = ui.Menu("English", "German", "", "Setup", "Help", "About", "", "Exit")

--#endregion

--#region Window

local Window     = ui.Window("ecPerson", "single", 710, 530)
Window.menu      = ui.Menu()
Window.menu:add("|||", MenuBurger)

--#endregion

--#region Managers

Window.CM                = cm.ConfigurationManager()
Window.DM                = dm.DataManager()
Window.GM_CONTACT        = gm.GeometryManager():RowLayout(Window, gm.DIRECTION.Left, 8, 30, 185, 650, 135)
Window.GM_LOCATION_ENTRY = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 460, 14, 220, 166)
Window.GM_LOCATION_LABEL = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 370, 18, 80, 166)
Window.GM_MENU           = gm.GeometryManager():BottomLayout(Window, gm.DIRECTION.Left, 8, { 29, 30, 10, 59 }, 34)
Window.GM_NAME_ENTRY     = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 120, 14, 220, 166)
Window.GM_NAME_LABEL     = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 30, 18, 80, 166)
Window.GM_NOTE           = gm.GeometryManager():BottomLayout(Window, gm.DIRECTION.Left, 0, { 30, 30, 10, 111 }, 80)
Window.KM                = km.KeyManager()
Window.LM                = lm.LocalizationManager()
Window.MM                = mm.MenuManager()
Window.VM                = vm.ValidationManager()
Window.WM                = wm.WidgetManager()
Window.WM_ZERO           = wm.WidgetManager()

--#endregion

--#region Widgets

local Panel              = ui.Panel(Window, 0, 0, 710, 166)

local LabelLastName      = ui.Label(Panel, "Last Name", 0, 0, 80, 20)
local LabelFirstName     = ui.Label(Panel, "First Name", 0, 0, 80, 20)
local LabelMiddleName    = ui.Label(Panel, "Middle Name", 0, 0, 80, 20)
local LabelCompany       = ui.Label(Panel, "Company", 0, 0, 80, 20)
local LabelDepartment    = ui.Label(Panel, "Department", 0, 0, 80, 20)

local LabelStreet        = ui.Label(Panel, "Street", 0, 0, 80, 20)
local LabelCity          = ui.Label(Panel, "City", 0, 0, 80, 20)
local LabelPostalCode    = ui.Label(Panel, "Postal Code", 0, 0, 80, 20)
local LabelState         = ui.Label(Panel, "State", 0, 0, 80, 20)
local LabelCountry       = ui.Label(Panel, "Country", 0, 0, 80, 20)

local EntryLastName      = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryFirstName     = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryMiddleName    = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryCompany       = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryDepartment    = ui.Entry(Panel, "", 0, 0, 220, 24)

local EntryStreet        = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryCity          = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryPostalCode    = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryState         = ui.Entry(Panel, "", 0, 0, 220, 24)
local EntryCountry       = ui.Entry(Panel, "", 0, 0, 220, 24)

local ColumnContacts     = uiextension.ColumnPanel(Window, ui.Entry, 5, 6, 0, 0, 586, 110)
local ColumnEdit         = uiextension.ColumnPanel(Window, ui.Button, 5, 4, 0, 0, 24, 110, "#")
local ColumnDelete       = uiextension.ColumnPanel(Window, ui.Button, 5, 4, 0, 0, 24, 110, "X")

local EditNote           = ui.Edit(Window, "", 0, 0, 648, 150)

local ButtonFirst        = ui.Button(Window, "|<", 0, 0, 55, 34)
local ButtonPrevious     = ui.Button(Window, "<", 0, 0, 55, 34)
local ButtonFilter       = ui.Button(Window, "(   )", 0, 0, 67, 34)
local ButtonNext         = ui.Button(Window, ">", 0, 0, 55, 34)
local ButtonLast         = ui.Button(Window, ">|", 0, 0, 55, 34)
local ButtonNew          = ui.Button(Window, "New", 0, 0, 75, 34)
local ButtonSave         = ui.Button(Window, "Save", 0, 0, 75, 34)
local ButtonCancel       = ui.Button(Window, "Cancel", 0, 0, 75, 34)
local ButtonDelete       = ui.Button(Window, "Delete", 0, 0, 75, 34)

--#endregion

--#region WidgetManager

Window.WM:add(EntryLastName, "EntryLastName")
Window.WM:add(ButtonFirst, "ButtonFirst")
Window.WM:add(ButtonPrevious, "ButtonPrevious")
Window.WM:add(ButtonFilter, "ButtonFilter")
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
Window.WM_ZERO:add(ButtonFilter, "ButtonFilter")
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
Window.KM:add(ButtonFilter, "VK_F2")
Window.KM:add(ButtonNext, "VK_NEXT")
Window.KM:add(ButtonLast, "VK_END")
Window.KM:add(ButtonNew, "VK_F3")
Window.KM:add(ButtonSave, "VK_F4")
Window.KM:add(ButtonDelete, "VK_F5")
Window.KM:add(ButtonCancel, "VK_F6")

--#endregion

--#region LocalizationManager

Window.LM:add(MenuBurger.items[1], "text", "English")
Window.LM:add(MenuBurger.items[2], "text", "German")
Window.LM:add(MenuBurger.items[4], "text", "Setup")
Window.LM:add(MenuBurger.items[5], "text", "Help")
Window.LM:add(MenuBurger.items[6], "text", "About")
Window.LM:add(MenuBurger.items[7], "text", "Exit")

Window.LM:add(LabelLastName, "text", "LastName")
Window.LM:add(LabelFirstName, "text", "FirstName")
Window.LM:add(LabelMiddleName, "text", "MiddleName")
Window.LM:add(LabelCompany, "text", "Company")
Window.LM:add(LabelDepartment, "text", "Department")
Window.LM:add(LabelStreet, "text", "Street")
Window.LM:add(LabelCity, "text", "City")
Window.LM:add(LabelPostalCode, "text", "PostalCode")
Window.LM:add(LabelState, "text", "State")
Window.LM:add(LabelCountry, "text", "Country")

Window.LM:add(ButtonFirst, "tooltip", "FirstPage")
Window.LM:add(ButtonPrevious, "tooltip", "PreviousPage")
Window.LM:add(ButtonFilter, "tooltip", "Filter")
Window.LM:add(ButtonNext, "tooltip", "NetxPage")
Window.LM:add(ButtonLast, "tooltip", "LastPage")
Window.LM:add(ButtonNew, "text", "New")
Window.LM:add(ButtonSave, "text", "Save")
Window.LM:add(ButtonDelete, "text", "Delete")
Window.LM:add(ButtonCancel, "text", "Cancel")

--endregion

--#region GeometryManager: NAME

Window.GM_NAME_LABEL:add(LabelLastName)
Window.GM_NAME_LABEL:add(LabelFirstName)
Window.GM_NAME_LABEL:add(LabelMiddleName)
Window.GM_NAME_LABEL:add(LabelCompany)
Window.GM_NAME_LABEL:add(LabelDepartment)

Window.GM_NAME_ENTRY:add(EntryLastName)
Window.GM_NAME_ENTRY:add(EntryFirstName)
Window.GM_NAME_ENTRY:add(EntryMiddleName)
Window.GM_NAME_ENTRY:add(EntryCompany)
Window.GM_NAME_ENTRY:add(EntryDepartment)

--#endregion

--#region GeometryManager:LOCATION

Window.GM_LOCATION_LABEL:add(LabelStreet)
Window.GM_LOCATION_LABEL:add(LabelCity)
Window.GM_LOCATION_LABEL:add(LabelPostalCode)
Window.GM_LOCATION_LABEL:add(LabelState)
Window.GM_LOCATION_LABEL:add(LabelCountry)

Window.GM_LOCATION_ENTRY:add(EntryStreet)
Window.GM_LOCATION_ENTRY:add(EntryCity)
Window.GM_LOCATION_ENTRY:add(EntryPostalCode)
Window.GM_LOCATION_ENTRY:add(EntryState)
Window.GM_LOCATION_ENTRY:add(EntryCountry)

--#endregion

--#region GeometryManager: CONTACT

Window.GM_CONTACT:add(ColumnContacts)
Window.GM_CONTACT:add(ColumnEdit)
Window.GM_CONTACT:add(ColumnDelete)

--#endregion

--#region GeometryManager: NOTE

Window.GM_NOTE:add(EditNote)

--#endregion

--#region GeometryManager: MENU (ÄNDERN)

Window.GM_MENU:add(ButtonFirst)
Window.GM_MENU:add(ButtonPrevious)
Window.GM_MENU:add(ButtonFilter)
Window.GM_MENU:add(ButtonNext)
Window.GM_MENU:add(ButtonLast)
Window.GM_MENU:add(ButtonNew)
Window.GM_MENU:add(ButtonSave)
Window.GM_MENU:add(ButtonCancel)
Window.GM_MENU:add(ButtonDelete)

--#endregion

--#region ConfigurationManager

Window.CM:add(MenuBurger.items[1], "checked", "LanguageEnglish")
Window.CM:add(MenuBurger.items[2], "checked", "LanguageGerman")

--#endregion

--#region ValidationManager

Window.VM:add(EntryLastName, "text", isRequired, "LastNameRequired")

--#endregion

--#region DataManager

Window.DM:add("lastname", EntryLastName, "text", "")
Window.DM:add("firstname", EntryFirstName, "text", "")
Window.DM:add("middlename", EntryMiddleName, "text", "")
Window.DM:add("company", EntryCompany, "text", "")
Window.DM:add("department", EntryDepartment, "text", "")
Window.DM:add("street", EntryStreet, "text", "")
Window.DM:add("city", EntryCity, "text", "")
Window.DM:add("postalcode", EntryPostalCode, "text", "")
Window.DM:add("state", EntryState, "text", "")
Window.DM:add("country", EntryCountry, "text", "")

--#endregion

return Window
