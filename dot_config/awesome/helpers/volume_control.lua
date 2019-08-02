local awful = require("awful")

local volume_get_cmd =
  [[pactl list sinks | \
    grep -m 1 'Volume:' | \
    awk '{print $5}' | \
    cut -d '%' -f1]]
local muted_get_cmd = 
  [[pactl list sinks | \
  grep -m 1 'Mute:' | \
  awk '{printf \"%s\", $2}']]

local volume_notif

function volume_control(step)
  local cmd
  if step == 0 then
    cmd =
      "pactl set-sink-mute @DEFAULT_SINK@ toggle && "
      ..muted_get_cmd
    awful.spawn.with_shell(cmd)
  else
    sign = step > 0 and "+" or ""

    cmd =
      [[pactl set-sink-mute 0 @DEFAULT_SINK@ && \
        pactl set-sink-volume @DEFAULT_SINK@ ]]
        ..sign..tostring(step).."% && "..volume_get_cmd
    
    awful.spawn.easy_async_with_shell(cmd, function(out)
      print(out)
      out = out:gsub('^%s*(.-)%s*$', '%1')
      print(out)
      if not sidebar.visible then
        if volume_notif and not volume_notif.is_expired then
          volume_notif.message = out
        else
          volume_notif = naughty.notification({ title = "Volume", message = out, timeout = 2 })
        end
      end
    end)
  end
end