--[[
=== ChargerNotify ===

Show a notification when you connect a charger that isn't yours
]]

local obj={}

-- Metadata
obj.name = "ChargerNotify"
obj.version = "0.1"
obj.author = "Carey Metcalfe"
obj.license = "GNU GPLv3"
obj.homepage = "https://github.com/pR0Ps/dotfiles/.hammerspoon/Spoons/ChargerNotify.spoon"


function obj:isKnown(serial)
    for _, v in ipairs(self.knownSerials) do
        if v == serial then
            return true
        end
    end
    return false
end


function obj:batteryChangedCallback()
    psuSerial = hs.battery.adapterSerialNumber()

    -- unplugged/unknown
    if psuSerial == nil then
      return
    end

    psuSerial = tostring(psuSerial)

    -- PSUs can randomly disconnect and reconnect for some reason
    -- Only show warnings if the PSU is different from the last one connected
    if self.lastSerial == psuSerial then
      return
    end

    if not obj:isKnown(psuSerial) then
      hs.alert.showWithImage("That's not your charger!", self.image, 5)
    end

    self.lastSerial = psuSerial
end


function obj:start()
  self.batteryWatcher:start()
  return self
end


function obj:stop()
  self.batteryWatcher:stop()
  return self
end


function obj:addKnownPSUs(serials)
  self.knownSerials = serials
  return self
end


function obj:init()
  self.lastSerial = nil
  self.knownSerials = {}
  self.image = hs.image.imageFromName(hs.image.systemImageNames["Caution"]):setSize({h=50,w=50})
  self.batteryWatcher = hs.battery.watcher.new(function() self:batteryChangedCallback() end)
  return self
end


return obj
