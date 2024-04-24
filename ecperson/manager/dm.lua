local ui = require("ui")

-- Defines a validation management module.
local dm = {} -- version 2.0

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
    "thread"
  }

  return not table.concat(invalidTypes, ","):find(type(parameter))
end

-- Checks if the parameter is a string type.
-- isString(parameter: any) -> boolean
local function isString(parameter)
  return type(parameter) == "string"
end

-- Checks if the paramter is a function type.
-- isFunction(parameter: any) -> boolean
local function isFunction(parameter)
  return type(parameter) == "function"
end

-- Defines the validation manager object.
local DataManager = Object({})

-- Creates the validation manager constructor.
function DataManager:constructor()
  self.fields = {}
  self.values = {}
  self.children = {}
end

-- Adds a widget, property, validation rule and error message.
-- add(widget: object, property: string, rule: function, message: string) -> none
function DataManager:add(field, widget, property) --, rule, message)
  local newChild = {
    widget = widget,
    field = field,
    property = property
  }

  table.insert(self.children, newChild)
end

-- Performs validation checks for each widget.
-- apply() -> none
function DataManager:apply()
  self.fields = {}
  self.values = {}

  for _, child in pairs(self.children) do
    table.insert(self.fields, child.field)
    table.insert(self.values, child.widget[child.property])
  end
end

function DataManager:insert(database, name)
  local sqlSchema = "INSERT INTO " .. name .. " "
  sqlSchema = sqlSchema .. "(" .. table.concat(self.fields, ", ") .. ") "
  sqlSchema = sqlSchema .. "VALUES('" .. table.concat(self.values, "', '") .. "');"

  ui.info(sqlSchema)

  database:exec(sqlSchema)
end

-- ok
function DataManager:select(database, name, record)
  local query = "SELECT * FROM " .. name .. " ORDER BY id ASC LIMIT 1 OFFSET " .. record .. ";"

  local row = database:exec(query)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end

  database.current = row["id"]
end

function DataManager:selectone(database, name, id)
  local query = "SELECT * FROM " .. name .. " WHERE id = " .. id .. ";"
  ui.info(query)

  local row = database:exec(query)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end
end

function DataManager:update(database, name)
  local query = "UPDATE " .. name .. " SET "

  for _, child in ipairs(self.children) do
    query = query .. child.field .. " = '" .. child.widget[child.property] .. "', "
  end

  query = string.sub(query, 1, -3)

  query = query .. " WHERE id = " .. database.current .. ";"

  ui.info(query)

  database:exec(query)
end

function DataManager:delete(database, name)
  local query = "DELETE FROM " .. name .. " WHERE id = " .. database.current .. ";"
  database:exec(query)
end

-- Initializes a new validation manager instance.
-- DataManager() -> object
function dm.DataManager()
  return DataManager()
end

return dm
