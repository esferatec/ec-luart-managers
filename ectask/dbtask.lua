local sqlite = require("sqlite")

local app = require("resources.app")

local Task = sqlite.Database(app.DATABASE.fullpath)

Task.table = "tbl_task"
Task.record = nil
Task.total = 0

function Task:create()
  self:exec([[CREATE TABLE IF NOT EXISTS "tbl_task" (
    "id" INTEGER NOT NULL,
    "subject" TEXT NOT NULL,
    "task01" TEXT,
    "task02" TEXT,
    "task03" TEXT,
    "task04" TEXT,
    "task05" TEXT,
    "task06" TEXT,
    "task07" TEXT,
    "task08" TEXT,
    "task09" TEXT,
    "task10" TEXT,
    "task11" TEXT,
    "task12" TEXT,
    "task13" TEXT,
    "task14" TEXT,
    "task15" TEXT,
    "task16" TEXT,
    "task17" TEXT,
    "task18" TEXT,
    "task19" TEXT,
    "task20" TEXT,
    "done01" TEXT DEFAULT "true",
    "done02" TEXT DEFAULT "true",
    "done03" TEXT DEFAULT "true",
    "done04" TEXT DEFAULT "true",
    "done05" TEXT DEFAULT "true",
    "done06" TEXT DEFAULT "true",
    "done07" TEXT DEFAULT "true",
    "done08" TEXT DEFAULT "true",
    "done09" TEXT DEFAULT "true",
    "done10" TEXT DEFAULT "true",
    "done11" TEXT DEFAULT "true",
    "done12" TEXT DEFAULT "true",
    "done13" TEXT DEFAULT "true",
    "done14" TEXT DEFAULT "true",
    "done15" TEXT DEFAULT "true",
    "done16" TEXT DEFAULT "true",
    "done17" TEXT DEFAULT "true",
    "done18" TEXT DEFAULT "true",
    "done19" TEXT DEFAULT "true",
    "done20" TEXT DEFAULT "true",
    "note" BLOB,
    PRIMARY KEY("id" AUTOINCREMENT)
  );]])
end

function Task:count()
  local statment = string.format("SELECT COUNT(*) as count FROM %s;", self.table)
  local result = self:exec(statment)
  return result["count"]
end

function Task:list()
  local result = {}
  local statment = string.format("SELECT subject as subject FROM %s;", self.table)

  for task in self:query(statment) do
    table.insert(result, task.subject)
  end

  return result
end

return Task
