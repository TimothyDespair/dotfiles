local awful = require("awful")
local beautiful = require("beautiful")

local make_button = require("bars/helpers/make_button")

local volume_control = require("helpers/volume_control")

local volume_char = "🔈" -- Unicode Speaker
local volume_muted_color = beautiful.xcolor8
local volume_unmuted_color = beautiful.xcolor5
local volume_button_color = beautiful.xcolor0
local volume_button_hover_color = beautiful.xcolor13
local volume = make_button
  ( volume_char
  , volume_unmuted_color
  , volume_button_color
  , volume_button_hover_color )

volume:buttons(gear.table.join(
  awful.button({ }, 3, function()
    volume_control(0) TODO
  end)
  awful.button({ }, 3, function()
    -- Volume GUI
  end)
  awful.button({ }, 4, function ()
    volume_control(5)
  end)
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
end)

return volume
