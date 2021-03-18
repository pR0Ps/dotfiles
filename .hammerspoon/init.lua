-- Hammerspoon config file

-- auto reload config when it changes (enable for development)
--configFileWatcher = hs.pathwatcher.new(hs.configdir, hs.reload):start()

-- Default hammerspoon activation key(s)
local hyper = {"alt"}

-- Work around paste blocking by "typing" the contents of the clipboard
hs.hotkey.bind(hyper, "v", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- Sleep display
-- Locks if Preferences -> Security and Privacy -> General -> "Require pasword ..." is set to "immediately"
hs.hotkey.bind(hyper, 'l', function() hs.execute('pmset displaysleepnow')  end)

-- Show a menubar icon for keeping the computer awake
hs.loadSpoon("Caffeinate")

-- Show a menubar icon for listing/ejecting disks
hs.loadSpoon("DiskMenu")

-- Window management
hs.window.animationDuration = 0.05 --default is 0.2
hs.loadSpoon("MiroWindowsManager"):bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "return"}
})

