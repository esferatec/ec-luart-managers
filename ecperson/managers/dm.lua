local ui = require("ui")

-- Defines a data management module.
local dm = {} -- version 1.0

-- Defines the data manager object.
local DataManager = Object({})

-- Creates the data manager constructor.
function DataManager:constructor()
  self.fields = {}
  self.values = {}
  self.children = {}
  self.key = nil
end

-- Adds a field, widget and property.
-- add(field: string, widget: object, property: string) -> none
function DataManager:add(field, widget, property, default)
  local newChild = {
    field = field,
    widget = widget,
    property = property,
    default = default
  }

  table.insert(self.children, newChild)
end

-- XY.
-- apply() -> none
function DataManager:apply()
  self.fields = {}
  self.values = {}

  for _, child in pairs(self.children) do
    table.insert(self.fields, child.field)
    table.insert(self.values, child.widget[child.property])
  end
end

-- ok
function DataManager:clear()
  for _, child in ipairs(self.children) do
    child.widget[child.property] = child.default
  end
end

-- ok
function DataManager:select(database, name, record)
  local query = "SELECT * FROM " .. name .. " ORDER BY id ASC LIMIT 1 OFFSET " .. record .. ";"

  local row = database:exec(query)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end

  self.key = row["id"]
end

function DataManager:selectone(database, tablename)
  local statement = "SELECT * FROM " .. tablename .. " "
  statement = statement .. "WHERE id = " .. self.key .. ";"

  local row = database:exec(statement)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end
end

-- Insert a row to the table.
-- insert(database: object, tablename: string) -> none
function DataManager:selectfirst(database, tablename)
  local statement = "SELECT * FROM " .. tablename .. " "
  statement = statement .. "ORDER BY id ASC LIMIT 1;"

  local row = database:exec(statement)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end

  self.key = row["id"]
end

-- Insert a row to the table.
-- insert(database: object, tablename: string) -> none
function DataManager:selectlast(database, tablename)
  local statement = "SELECT * FROM " .. tablename .. " "
  statement = statement .. "ORDER BY id DESC LIMIT 1;"

  local row = database:exec(statement)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end

  self.key = row["id"]
end

-- Insert a row to the table.
-- insert(database: object, tablename: string) -> none
function DataManager:insert(database, tablename)
  local statement = "INSERT INTO " .. tablename .. " "
  statement = statement .. "(" .. table.concat(self.fields, ", ") .. ") "
  statement = statement .. "VALUES('" .. table.concat(self.values, "', '") .. "');"

  database:exec(statement)
end

-- Update a row from the table.
-- update(database: object, tablename: string) -> none
function DataManager:update(database, tablename)
  local statement = "UPDATE " .. tablename .. " SET "
  for _, child in ipairs(self.children) do
    statement = statement .. child.field .. " = '" .. child.widget[child.property] .. "', "
  end
  statement = string.sub(statement, 1, -3)

  database:exec(statement)
end

-- Delete a row from the table.
-- delete(database: object, tablename: string) -> none
function DataManager:delete(database, tablename)
  local statement = "DELETE FROM " .. tablename .. " "
  statement = statement .. "WHERE id = " .. self.key .. ";"

  database:exec(statement)
end

-- Initializes a new data manager instance.
-- DataManager() -> object
function dm.DataManager()
  return DataManager()
end

return dm
