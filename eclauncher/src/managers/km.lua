-- Defines a key management module.
local km = {} -- version 1.1

-- Defines specific constants.
km.MODIFIERKEY = { Alt = "VK_MENU", Ctrl = "VK_CONTROL", Shift = "VK_SHIFT" }

-- Checks if the parameter is a valid child widget.
-- isValidChild(parameter: any) -> boolean
local function isValidChild(parameter)
  local invalidTypes = {
    "nil",
    "boolean",
    "number",
    "string",
    "userdata",
    "function",
    "thread" }

  return not table.concat(invalidTypes, ","):find(type(parameter))
end

-- Checks if the parameter is a string type.
-- isString(parameter: any) -> boolean
local function isString(parameter)
  return type(parameter) == "string"
end

-- Defines the key manager object.
local KeyManager = Object({})

-- Creates the key manager constructor.
function KeyManager:constructor()
  self.modifier = nil
  self.children = {}
end

-- Adds a widget and sets the key.
-- add(widget: object, key: string) -> none
function KeyManager:add(widget, key)
  if not isValidChild(widget) then return end
  if not isString(key) then return end
  if key == "" then return end

  self.children[key] = widget
end

-- Executes the command when the key is invoked.
-- apply(key: string) -> none
function KeyManager:apply(key)
  if not isString(key) then return end
  if key == "" then return end

  local gesture = key

  if self.modifier == nil then
    if key == km.MODIFIERKEY.Alt then
      self.modifier = km.MODIFIERKEY.Alt
      return
    elseif key == km.MODIFIERKEY.Ctrl then
      self.modifier = km.MODIFIERKEY.Ctrl
      return
    elseif key == km.MODIFIERKEY.Shift then
      self.modifier = km.MODIFIERKEY.Shift
      return
    end
  else
    gesture = self.modifier .. "+" .. key
  end

  local child = self.children[gesture]
  if child and type(child.onClick) == "function" and child.enabled then
    child:onClick()
  end

  self.modifier = nil
end

-- Initializes a new key manager instance.
-- KeyManager() -> object
function km.KeyManager()
  return KeyManager()
end

return km
