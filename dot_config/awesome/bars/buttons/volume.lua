local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local terminal = require("settings").terminal

local beautiful = require("beautiful")

local button_container = require("bars/helpers/button_container")

local volume_muted_color        = beautiful.xcolor8
local volume_unmuted_color      = beautiful.xcolor5
local volume_button_color       = beautiful.xcolor0
local volume_button_hover_color = beautiful.xcolor13
local volume_icon = beautiful.volume_icon

local get_volume_cmd =
  [[ pactl list sinks \
     | grep "Base Volume" \
     | awk '{print substr($5, 0, length($5)-1)} ]]

local inc_volume_cmd =
  [[ pactl set-sink-volume 0 +5% ]]
local dec_volume_cmd =
  [[ pactl set-sink-volume 0 -5% ]]

local mute_volume_cmd =
  [[ pactl set-sink-mute 0 toggle ]]

local volume = wibox.widget
  { image = volume_icon(20)
  , widget = wibox.widget.imagebox }

local volume_cache
local muted_cache

local update_volume = function ()
  awful.spawn.easy_async
    ( "pactl list sinks"
    , function(stdout)
        local vol = stdout:match('(%d+)%% /')
        local mute = stdout:match('Mute:(%s+)[yes]')
	if mute ~= nil and vol ~= volume_cache then
	  volume_cache = vol
	  volume:set_image(volume_icon(tonumber(vol)))
	elseif mute ~= muted_cache then
	  muted_cache = mute
	  volume:set_image(volume_icon(tonumber(vol)))
	end
      end )
end

gears.timer
  { autostart = true
  , timeout = 1
  , callback = update_volume }

volume:buttons(gears.table.join(
  awful.button({ }, 3, function()
    awful.spawn(mute_volume_cmd, false)
    update_volume()
  end),
  awful.button({ }, 3, function()
    -- Volume GUI
  end),
  awful.button({ }, 4, function ()
    awful.spawn(inc_volume_cmd, false)
    update_volume()
  end),
  awful.button({ }, 5, function ()
    awful.spawn(dec_volume_cmd, false)
    update_volume()
  end)
))

local button = button_container(volume, volume_button_color, volume_button_hover_color)

return button
