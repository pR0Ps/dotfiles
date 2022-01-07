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

-- Show an alert when connecting an unknown charger
hs.loadSpoon("ChargerNotify"):addKnownPSUs({"16974587"}):start()

-- Window management
hs.window.animationDuration = 0.05 --default is 0.2
hs.loadSpoon("MiroWindowsManager"):bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "return"}
})

-- Pause/unpause the current application
hs.hotkey.bind(hyper, "p", function()
  local app = hs.application.frontmostApplication()
  local pid = app:pid()
  local stopped = hs.execute(string.format("ps -p %s -ostat=", pid), false):sub(1,1) == "T"

  --Note that negating the PID sends the signal to the entire process group
  os.execute(string.format("kill -%s -%s", stopped and "CONT" or "STOP", pid))
  hs.alert.showWithImage(
    string.format(stopped and "Resumed" or "Paused"),
    hs.image.imageFromAppBundle(app:bundleID()):setSize({h=50,w=50})
  )
end)

