--[[
=== DiskMenu ===

A disk menu for the macOS menu bar.
Shows all drives and provides buttons for opening/ejecting them.
]]

local obj={}

-- Metadata
obj.name = "DiskMenu"
obj.version = "0.1"
obj.author = "Carey Metcalfe"
obj.license = "GNU GPLv3"
obj.homepage = "https://github.com/pR0Ps/dotfiles/.hammerspoon/Spoons/DiskMenu.spoon"

obj.menubar = nil


-- Display bytes in a human-readable format
function obj:humanSize(bytes)
  if bytes ~= nil then
    local units = {'B', 'KB', 'MB', 'GB', 'TB', 'PB'}
    local power = math.floor(math.log(bytes, 1024))
    return string.format("%.1f " .. units[power + 1], bytes/(1024^power))
  else
    return "??"
  end
end

-- Return a table of menu items to display
function obj:makeMenu()
  -- Preload the table with a link to the Disk Utility and a separator
  local entries = {
    {
      title="Disk Utility",
      fn=function()
        hs.application.launchOrFocus("Disk Utility")
      end
    },
    {
      title= "-"
    }
  }

  for path, data in pairs(hs.fs.volume.allVolumes()) do
      local name = data.NSURLVolumeLocalizedNameKey
      local size = data.NSURLVolumeTotalCapacityKey
      local browsable = data.NSURLVolumeIsBrowsableKey
      local free = data.NSURLVolumeAvailableCapacityKey
      local used = nil
      if size ~= nil and free ~= nil then
        used = size-free
      end

      -- Add an entry for the drive
      table.insert(entries, {
        title=string.format("%s (%s/%s)", name, self:humanSize(used), self:humanSize(size)),
        disabled=not browsable,
        fn=function()
          hs.execute(string.format("open %q", path))
        end
      })

      -- Add an eject subentry if the volume can be ejected
      -- See https://github.com/Hammerspoon/hammerspoon/issues/2885
      if data.NSURLVolumeIsRemovableKey or data.NSURLVolumeIsEjectableKey then
        table.insert(entries, {
          title="⏏ Eject",
          indent=1,
          fn=function()
            -- Attempt to eject and notify of the result
            ejected, msg = hs.fs.volume.eject(path)
            hs.notify.new({
              title="DiskMenu",
              subTitle=string.format(ejected and "Volume %s was ejected" or "Error ejecting %s", name),
              informativeText=msg,
              withdrawAfter=ejected and 3 or 0
            }):send()
          end
        })
      end
  end

  return entries
end

-- Create the menubar with a disk icon
-- Populate the menu when it's clicked
function obj:init()
  self.menubar = hs.menubar.new():
  setIcon(
    hs.image.imageFromPath(
      "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/SidebarRemovableDisk.icns"
    ):
    setSize({w=16,h=16})
  ):
  setMenu(function() return self:makeMenu() end)
  return self
end

return obj
