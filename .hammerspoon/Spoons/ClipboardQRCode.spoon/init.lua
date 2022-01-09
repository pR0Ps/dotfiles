--[[
=== ClipboardQRCode ===

Make clipboard contents available via a QR code.
Requires `qrencode` (https://fukuchi.org/works/qrencode/) to be available on the PATH.
]]

local obj={}

-- Metadata
obj.name = "ClipboardQRCode"
obj.version = "0.1"
obj.author = "Carey Metcalfe"
obj.license = "GNU GPLv3"
obj.homepage = "https://github.com/pR0Ps/dotfiles/.hammerspoon/Spoons/ClipboardQRCode.spoon"


function obj:dismiss()
  if self.alert_id == nil then return end

  hs.alert.closeSpecific(self.alert_id)
  self.alert_id = nil

  return self
end


function obj:show()
  -- TODO: Allow sending copied files by starting an HTTP server and showing a URL?
  if self.alert_id ~= nil then obj:dismiss() end

  local clip_data = hs.pasteboard.readString()
  local clip_len = #clip_data
  if clip_len > 1000 then
    hs.alert.show(string.format("Too much data to generate a QR code for (cur: %s max: %s)", clip_len, 1000))
    return
  end

  -- Using files for IO since I couldn't get large/binary stdout working nicely with hs.task
  local tmpdir, status = hs.execute("mktemp -d")
  if not status then return end
  tmpdir = tmpdir:sub(1, #tmpdir-1) -- strip trailing newline

  local input, output = tmpdir .. "/input", tmpdir .. "/output"
  f = io.open(input, "w")
  if f then
    f:write(clip_data)
    f:close()

    local _, status = hs.execute(string.format("qrencode -r '%s' -o '%s' -t PNG -m 1 -s 10", input, output), true)
    if status then
      self.alert_id = hs.alert.showWithImage("", hs.image.imageFromPath(output), {atScreenEdge=1}, "inf")
    end
  end

  -- Clean up
  hs.execute(string.format("rm '%s' '%s'; rmdir '%s'", input, output, tmpdir))

  return self
end


function obj:toggle()
  if self.alert_id == nil then
    self:show()
  else
    self:dismiss()
  end
end


function obj:bindHotkeys(mapping)
  hs.hotkey.bind(mapping[1], mapping[2], function() self:toggle() end)
  return self
end


function obj:init()
  self.alert_id = nil
  return self
end


return obj
