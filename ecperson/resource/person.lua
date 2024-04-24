require("common.extension")

local sqlite = require("sqlite")

local Person = sqlite.Database("gg.db") --(arg[1] == nil) and database.Person(":memory:") or database.Person(arg[1])

function Person:create()
  self:exec([[CREATE TABLE IF NOT EXISTS "tbl_person" (
    "id"	INTEGER NOT NULL,
    "lastname"	TEXT NOT NULL,
    "firstname"	TEXT,
    "middlename"	TEXT,
    "company"	TEXT,
    "department"	TEXT,
    "street"	TEXT,
    "city"	TEXT,
    "postalcode"	TEXT,
    "state"	TEXT,
    "country"	TEXT,
    "note"	BLOB,
    PRIMARY KEY("id" AUTOINCREMENT)
  );]])
end

function Person:save(path)
  if not isstring(path) then return end
  if string.trim(path) == "" then return end
  self:exec("VACUUM main INTO '" .. path .. "';")
end

function Person:countall()
  local result = self:exec("SELECT COUNT(*) FROM tbl_person;")
  return result["COUNT(*)"]
end

return Person
