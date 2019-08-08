local awful = require("awful")
local gears = require("gears")

local beautiful = require("beautiful")

local make_button = require("bars/helpers/make_button")

local volume_control = require("helpers/volume_control")

local bv = beautiful.volume -- For checking values exist quickly

local clock_color        = bv and bv.muted_color or beautiful.xcolor8
local clock_hover_color = bv and bv.hover_color or beautiful.xcolor13

local volume = make_button
  ( beautiful.clock_icon(14, 32)
  , clock_color
  , clock_hover_color )

awesome.connect_signal("evil::volume", function(_, muted)
  local t = volume:get_all_children()[1]
  if muted then
    t.markup = colorise_text(volume_symbol, volume_muted_color)
  else
    t.markup = colorise_text(volume_symbol, volume_unmuted_color)
  end
end)

return volume
