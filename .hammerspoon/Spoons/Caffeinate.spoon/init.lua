--[[
== Caffeinate ==

Adds an icon in the macOS menu bar that toggles preventing sleep
]]

local obj = {}

-- Metadata
obj.name = "Caffeinate"
obj.version = "0.1"
obj.author = "Carey Metcalfe"
obj.license = "GNU GPLv3"
obj.homepage = "https://github.com/pR0Ps/dotfiles/.hammerspoon/Spoons/Caffeinate.spoon"

-- Icons from https://github.com/IntelliScape/caffeine/ (MIT License)
obj.OFF_ICON = hs.image.imageFromPath(hs.spoons.resourcePath("off.png")):setSize({w=22,h=20})
obj.ON_ICON = hs.image.imageFromPath(hs.spoons.resourcePath("on.png")):setSize({w=22,h=20})

obj.menubar = nil


function obj.setIcon()
  obj.menubar:setIcon(hs.caffeinate.get("displayIdle") and obj.ON_ICON or obj.OFF_ICON)
end

function obj.toggle()
  hs.caffeinate.toggle("displayIdle")
  obj.setIcon()
end

function obj:setState(state)
    hs.caffeinate.set("displayIdle", state)
    obj.setIcon()
end

function obj:init()
  self.menubar = hs.menubar.new():setClickCallback(self.toggle)
  self:setIcon()
end

return obj
