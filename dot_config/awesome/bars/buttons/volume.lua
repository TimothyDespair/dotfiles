local awful = require("awful")
local beautiful = require("beautiful")

local make_button = require("bars/helpers/make_button")

local volume_control = require("helpers/volume_control")

local volume_char = beautiful.volume_char or "🔈" -- Unicode Speaker
local volume_font = beautiful.volume.font
local volume_muted_color = beautiful.volume_muted_color or beautiful.xcolor8
local volume_unmuted_color = beautiful.volume_unmuted_color or beautiful.xcolor5
local volume_button_color = beautiful.volume.bg_color or beautiful.xcolor0
local volume_button_hover_color = beautiful.volume.hover_color or beautiful.xcolor13

local volume = make_button
  ( volume_char
  , volume_unmuted_color
  , volume_button_color
  , volume_button_hover_color
  , volume_font )

volume:buttons(gear.table.join(
  awful.button({ }, 3, function()
    volume_control(0)
  end),
  awful.button({ }, 3, function()
    -- Volume GUI
  end),
  awful.button({ }, 4, function ()
    volume_control(5)
  end),
  awful.button({ }, 5, function ()
    volume_control(6)
  end)
))

awesome.connect_signal("evil::volume", function(_, muted)
  local t = volume:get_all_children()[1]
  if muted then
    t.markup = colorise_text(volume_symbol, volume_muted_color)
  else
    t.markup = colorise_text(volume_symbol, volume_unmuted_color)
  end
end)

return volume
