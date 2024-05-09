local sqlite = require("sqlite")

local app = require("resources.app")

local Person = sqlite.Database(app.DATABASE.fullpath)

Person.table = "tbl_person"
Person.record = nil
Person.total = 0

function Person:create()
  self:exec([[CREATE TABLE IF NOT EXISTS "tbl_person" (
    "id" INTEGER NOT NULL,
    "lastname" TEXT NOT NULL,
    "firstname" TEXT,
    "middlename" TEXT,
    "company" TEXT,
    "department" TEXT,
    "street" TEXT,
    "city" TEXT,
    "postalcode" TEXT,
    "state" TEXT,
    "country" TEXT,
    "contact1" TEXT,
    "contact2" TEXT,
    "contact3" TEXT,
    "contact4" TEXT,
    "contact5" TEXT,
    "note" BLOB,
    PRIMARY KEY("id" AUTOINCREMENT)
  );]])
end

--function Person:save(path)
--  if not isstring(path) then return end
--  if string.trim(path) == "" then return end
--  self:exec("VACUUM main INTO '" .. path .. "';")
--end

function Person:count()
  local statment = string.format("SELECT COUNT(*) as count FROM %s;", self.table)
  local result = self:exec(statment)
  return result["count"]
end

function Person:list()
  local result = {}
  local statment = string.format("SELECT lastname || ', ' || firstname as name FROM %s;", self.table)

  for person in self:query(statment) do
    table.insert(result, person.name)
  end

  return result
end

return Person
