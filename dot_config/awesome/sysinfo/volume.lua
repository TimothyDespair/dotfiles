local awful = require("awful")

local function emit_volume_info()
  awful.spawn.easy_async("pactl list sinks",
    function(stdout)
      local volume = stdout:match('(%d+)%% /')
      local muted = stdout:match('Mute:(%s+)[yes]')
      if muted ~= nil then
        awesome.emit_signal("sysinfo::volume", tonumber(volume), true)
      else
        awesome.emit_signal("sysinfo::volume", tonumber(volume), false)
      end
    end
  )
end

emit_volume_info()

local volume_script = [[
  bash -c '
  pactl subscribe 2> /dev/null | grep --line-buffered "sink"
']]

awful.spawn.easy_async_with_shell("ps x | grep \"pactl subscribe\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
  awful.spawn.with_line_callback(volume_script, {
    stdout = function(line)
      emit_volume_info()
    end
  })
end)
