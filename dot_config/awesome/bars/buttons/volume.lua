local awful = require("awful")
local gears = require("gears")

local beautiful = require("beautiful")

local make_button = require("bars/helpers/make_button")

local volume_control = require("helpers/volume_control")

local bv = beautiful.volume -- For checking values exist quickly

local volume_char               = bv and bv.char or "🔈" -- Unicode Speaker
local volume_font               = bv and bv.font
local volume_muted_color        = bv and bv.muted_color or beautiful.xcolor8
local volume_unmuted_color      = bv and bv.unmuted_color or beautiful.xcolor5
local volume_button_color       = bv and bv.bg_color or beautiful.xcolor0
local volume_button_hover_color = bv and bv.hover_color or beautiful.xcolor13

local volume = make_button
  ( volume_char
  , volume_unmuted_color
  , volume_button_color
  , volume_button_hover_color
  , volume_font )

volume:buttons(gears.table.join(
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
