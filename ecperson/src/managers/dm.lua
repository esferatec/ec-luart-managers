-- Defines a data management module.
local dm = {} -- version 0.1

-- Defines the data manager object.
local DataManager = Object({})

-- Creates the data manager constructor.
function DataManager:constructor()
  self.children = {}
  self.key = -1
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

-- Sets default value to all widgets property.
-- clear() -> none
function DataManager:clear()
  for _, child in ipairs(self.children) do
    child.widget[child.property] = child.default
  end

  self.key = -1
end

-- Select a row of the table.
-- select(database: object, tablename: string, record: number) -> none
function DataManager:select(database, tablename, record)
  local statement = string.format("SELECT * FROM %s ORDER BY id ASC LIMIT 1 OFFSET %d;", tablename, record)

  local row = database:exec(statement)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end

  self.key = row["id"]
end

-- Select one row of the table.
-- select_one(database: object, tablename: string) -> none
function DataManager:selectone(database, tablename)
  local statement = string.format("SELECT * FROM %s WHERE id = %d;", tablename, self.key)
  local row = database:exec(statement)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end
end

-- Select the first row of the table.
-- selectFirst(database: object, tablename: string) -> none
function DataManager:selectfirst(database, tablename)
  local statement = string.format("SELECT * FROM %s ORDER BY id ASC LIMIT 1;", tablename)
  local row = database:exec(statement)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end

  self.key = row["id"]
end

-- Select the last row of the table.
-- selectLast(database: object, tablename: string) -> none
function DataManager:selectlast(database, tablename)
  local statement = string.format("SELECT * FROM %s ORDER BY id DESC LIMIT 1;", tablename)
  local row = database:exec(statement)

  for _, child in ipairs(self.children) do
    child.widget[child.property] = row[child.field]
  end

  self.key = row["id"]
end

function DataManager:insert(database, tablename)
  local fields = {}
  local values = {}

  for _, child in ipairs(self.children) do
    table.insert(fields, child.field)
    table.insert(values, "'" .. child.widget[child.property] .. "'")
  end

  local fieldStr = table.concat(fields, ", ")
  local valueStr = table.concat(values, ", ")

  local statement = string.format("INSERT INTO %s (%s) VALUES (%s);", tablename, fieldStr, valueStr)

  database:exec(statement)
end

-- Update a row from the table.
-- update(database: object, tablename: string) -> none
function DataManager:update(database, tablename)
  local updates = {}

  for _, child in ipairs(self.children) do
    table.insert(updates, child.field .. " = '" .. child.widget[child.property] .. "'")
  end

  local updateString = table.concat(updates, ", ")

  local statement = string.format("UPDATE %s SET %s WHERE id = %d", tablename, updateString, self.key)

  database:exec(statement)
end

-- Delete a row from the table.
-- delete(database: object, tablename: string) -> none
function DataManager:delete(database, tablename)
  local statement = string.format("DELETE FROM %s WHERE id = %d;", tablename, self.key)
  database:exec(statement)
end

-- Initializes a new data manager instance.
-- DataManager() -> object
function dm.DataManager()
  return DataManager()
end

return dm
