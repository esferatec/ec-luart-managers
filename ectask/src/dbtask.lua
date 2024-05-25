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
    "done01" TEXT,
    "done02" TEXT,
    "done03" TEXT,
    "done04" TEXT,
    "done05" TEXT,
    "done06" TEXT,
    "done07" TEXT,
    "done08" TEXT,
    "done09" TEXT,
    "done10" TEXT,
    "done11" TEXT,
    "done12" TEXT,
    "done13" TEXT,
    "done14" TEXT,
    "done15" TEXT,
    "done16" TEXT,
    "done17" TEXT,
    "done18" TEXT,
    "done19" TEXT,
    "done20" TEXT,
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
