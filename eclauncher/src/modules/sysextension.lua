local sys = require("sys")

-- Provides various extension sys functions.
local sysextension = {}

--#region specialfolders

-- Gets the special folder full path.
local function getSpecialFolderPath(csidl)
  local WshShell = sys.COM("Shell.Application")
  return WshShell:NameSpace(csidl).self.path
end

-- Constants identify special folders.
local CSIDL = {
  appdata = 0x001a,
  commonappdata = 0x0023,
  commondesktop = 0x0019,
  commonprograms = 0x0017,
  commonstartmenu = 0x0016,
  commonstartup = 0x0018,
  desktop = 0x0010,
  documents = 0x0005,
  localappdata = 0x001c,
  music = 0x000d,
  pictures = 0x0027,
  profile = 0x0028,
  programfiles = 0x026,
  programfilesx86 = 0x002a,
  programs = 0x0002,
  recent = 0x0008,
  sendto = 0x0009,
  startmenu = 0x000b,
  startup = 0x0007,
  system = 0x0025,
  systemx86 = 0x0029,
  videos = 0x000e,
  windows = 0x0024,
}

-- Get a proxy table representing special folders.
sysextension.specialfolders = {
  desktop = getSpecialFolderPath(CSIDL.desktop),
  documents = getSpecialFolderPath(CSIDL.documents),
  music = getSpecialFolderPath(CSIDL.music),
  pictures = getSpecialFolderPath(CSIDL.pictures),
  programs = getSpecialFolderPath(CSIDL.programs),
  startmenu = getSpecialFolderPath(CSIDL.startmenu),
  videos = getSpecialFolderPath(CSIDL.videos),
}

--#endregion

--#region shortcut

sysextension.shortcut = {}

-- Creates a shortcut in the specified folder.
function sysextension.shortcut.create(folder, name, target)
  local shellObject = sys.COM("WScript.Shell")

  local shortcutFile = shellObject:CreateShortcut(folder .. "\\" .. name .. ".lnk")
  shortcutFile.TargetPath = target .. "\\" .. name .. ".exe"
  shortcutFile.WorkingDirectory = target
  shortcutFile.IconLocation = target .. "\\" .. name .. ".exe,0"
  shortcutFile:Save()
end

-- Deletes a shortcut from the specified folder.
function sysextension.shortcut.delete(folder, name)
  local shortcutFile = sys.File(folder .. "\\" .. name .. ".lnk")

  if shortcutFile.exists then
    shortcutFile:remove()
  end
end

--#endregion

return sysextension