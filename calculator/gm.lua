local MatrixLayout = require("calculator.layouts.matrixlayout")
local SingleLayout = require("calculator.layouts.singlelayout")

-- Defines a geometry management module.
local gm = {}

-- Defines specific constants.
gm.RESIZE = { X = 1, Y = 2, Both = 3, None = 4 }
gm.DIRECTION = { Left = 1, Right = 2, Top = 1, Bottom = 2 }
gm.ALIGNMENT = { Top = 1, Bottom = 2, Center = 3, Left = 1, Right = 2, Stretch = 4 }
gm.ANCHOR = { TopLeft = 1, TopRight = 2, BottomLeft = 3, BottomRight = 4, Center = 5 }

-- Defines the geometry manager object.
local GeometryManager = Object({})

-- Initializes a new matrix layout instance.
-- MatrixLayout(parent: object, columns?: number, rows?: number, require?[X, Y, Both, None]: number, gab?: number, positionx?: number, positiony?: number, width?: number, height?: number) -> object
function GeometryManager:MatrixLayout(parent, columns, rows, resize, gap, positionx, positiony, width, height)
    return MatrixLayout(parent, columns, rows, resize, gap, positionx, positiony, width, height)
end

-- Initializes a new single layout instance.
-- SingleLayout(parent: object, resize?[X, Y, Both, None]: number, positionx?: number, positiony?: number, width?: number, height?: number) -> object
function GeometryManager:SingleLayout(parent, resize, positionx, positiony, width, height)
    return SingleLayout(parent, resize, positionx, positiony, width, height)
end

-- Initializes a new geometry manager instance.
-- GeometryManager() -> object
function gm.GeometryManager()
    return GeometryManager()
end

return gm
