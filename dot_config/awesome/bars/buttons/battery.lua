-- TODO Make this use make_button

-- Adapted from streetturtle/awesome-wm-widgets
local battery = awful.widget.watch
  ( "acpi", 10
  , function ( widget, stdout )
      for s in stdout:gmatch("[^\r\n]+") do
        function error (msg)
          naughty.notify({text = msg}) end
        local words = {}
        for w in string.gmatch(s, '%S+') do
          table.insert(words, w) end
        local status = words[3]
        local source = ( status == "Discharging," ) and "BAT" or "AC"
        local percent = string.gsub ( words[4], ",", "" )
        local timeleft = "Done"
        if words[5] then
          timeleft = words[5] end
        widget:set_text( percent .. source .. "(" .. timeleft .. ")" )
        return end end )

return battery
