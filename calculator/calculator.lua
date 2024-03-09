-- Require necessary modules for UI, Geometry Manager, and Key Manager
local ui = require("ui")
local gm = require("calculator.ecluart.gm")
local km = require("calculator.ecluart.km")

-- Create a new window for the calculator with specified dimensions
local win = ui.Window("ecCalculator", "dialog", 300, 380)
win:status()

-- Set up the display layout using the Geometry Manager with specific parameters
local gem_display = gm.GeometryManager():SingleLayout(win, gm.RESIZE.X, 10, 10, 280, 50)

-- Set up the keypad layout using the Geometry Manager with specific parameters
local gem_keypad = gm.GeometryManager():MatrixLayout(win, 4, 5, gm.RESIZE.Both, 0, 10, 70, 280, 280)

-- Initialize the Key Manager for handling keypad input
local kem = km.KeyManager()

-- Create a new entry field with an initial value of "0"
local result = ui.Entry(win, "0")
result.textalign = "right"
result.fontsize = 20
result.fontstyle = { "bold" }
--result.enabled = false

-- Create all buttons and assign the function(self) result.text = result.text .. self.text end function to each onClick event
local key1 = ui.Button(win, "7")
key1.onClick = function(self) result.text = result.text .. self.text end
local key2 = ui.Button(win, "8")
key2.onClick = function(self) result.text = result.text .. self.text end
local key3 = ui.Button(win, "9")
key3.onClick = function(self) result.text = result.text .. self.text end
local key4 = ui.Button(win, "/")
key4.onClick = function(self) result.text = result.text .. self.text end

local key5 = ui.Button(win, "4")
key5.onClick = function(self) result.text = result.text .. self.text end
local key6 = ui.Button(win, "5")
key6.onClick = function(self) result.text = result.text .. self.text end
local key7 = ui.Button(win, "6")
key7.onClick = function(self) result.text = result.text .. self.text end
local key8 = ui.Button(win, "X")
key8.onClick = function(self) result.text = result.text .. self.text end

local key9 = ui.Button(win, "1")
key9.onClick = function(self) result.text = result.text .. self.text end
local key10 = ui.Button(win, "2")
key10.onClick = function(self) result.text = result.text .. self.text end
local key11 = ui.Button(win, "3")
key11.onClick = function(self) result.text = result.text .. self.text end
local key12 = ui.Button(win, "-")
key12.onClick = function(self) result.text = result.text .. self.text end

local key13 = ui.Button(win, "+/-")
local key14 = ui.Button(win, "0")
key14.onClick = function(self) result.text = result.text .. self.text end
local key15 = ui.Button(win, ".")
local key16 = ui.Button(win, "+")
key16.onClick = function(self) result.text = result.text .. self.text end

local key17 = ui.Button(win, "C")
key17.onClick = function(self)
    result.text = "0"
end
local empty18 = ui.Label(win, " ")
local key19 = ui.Button(win, "<")
local key20 = ui.Button(win, "=")
key20.onClick = function(self) result.text = result.text .. self.text end

-- Add the entry to the gem_display Geometry Manager
gem_display:add(result)

-- Add the buttons to the gem_keypad Geometry Manager
gem_keypad:add(key1)
gem_keypad:add(key2)
gem_keypad:add(key3)
gem_keypad:add(key4)
gem_keypad:add(key5)
gem_keypad:add(key6)
gem_keypad:add(key7)
gem_keypad:add(key8)
gem_keypad:add(key9)
gem_keypad:add(key10)
gem_keypad:add(key11)
gem_keypad:add(key12)
gem_keypad:add(key13)
gem_keypad:add(key14)
gem_keypad:add(key15)
gem_keypad:add(key16)
gem_keypad:add(key17)
gem_keypad:add(empty18)
gem_keypad:add(key19)
gem_keypad:add(key20)

-- Assigns a key to each key button and add this into the kem Key Manager
kem:add(key1, "VK_NUMPAD7")
kem:add(key1, "7")
kem:add(key2, "VK_NUMPAD8")
kem:add(key2, "8")
kem:add(key3, "VK_NUMPAD9")
kem:add(key3, "9")
kem:add(key5, "VK_NUMPAD4")
kem:add(key5, "4")
kem:add(key6, "VK_NUMPAD5")
kem:add(key6, "5")
kem:add(key7, "VK_NUMPAD6")
kem:add(key7, "6")
kem:add(key9, "VK_NUMPAD1")
kem:add(key9, "1")
kem:add(key10, "VK_NUMPAD2")
kem:add(key10, "2")
kem:add(key11, "VK_NUMPAD3")
kem:add(key11, "3")
kem:add(key14, "VK_NUMPAD0")
kem:add(key14, "0")
kem:add(key16, "VK_ADD")
kem:add(key12, "VK_SUBTRACT")
kem:add(key8, "VK_MULTIPLY")
kem:add(key4, "VK_DIVIDE")

function result:onChange()
    -- Check if the length of the text is not equal to 1 and the first character is "0"
    if #self.text ~= 1 and string.sub(self.text, 1, 1) == "0" then
        -- Remove leading "0" from the text
        self.text = self.text:gsub("^0", "")
    end
end

function win:onKey(key)
    win:status(key)
    -- Applying the key event to the kem object
    kem:apply(key)
end

function win:onResize()
    -- Check if the window height is less than 380 and greater than 0
    if win.height < 380 and win.height > 0 then
        win.height = 380
    end

    -- Check if the window width is less than 300 and greater than 0
    if win.width < 300 and win.width > 0 then
        win.width = 300
    end

    -- Update the gem_display Geometry Manager when the window is resized
    gem_display:update()

    -- Update the gem keypad Geometry Manager when the window is resized
    gem_keypad:update()
end

-- Arranges the widgets of the gem_display Geometry Manager
gem_display:apply()

-- Arranges the widgets of the gem_keypad Geometry Manager
gem_keypad:apply()

-- Running the user interface on the window and waiting for user input
ui.run(win):wait()
