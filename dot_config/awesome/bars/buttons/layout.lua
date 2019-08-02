local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local beautiful = require("beautiful")

local layout = function(s)
  local widget = awful.widget.layoutbox(s)

  layout:buttons ( gears.table.join
    ( awful.button({ }, 1, function() awful.layout.inc( 1) end )
    , awful.button({ }, 3, function() awful.layout.inc(-1) end )
    , awful.button({ }, 4, function() awful.layout.inc( 1) end )
    , awful.button({ }, 5, function() awful.layout.inc(-1) end ) ) )

  local section = wibox.widget
    { widget
    , forced_width =
        width or
        beautiful.bar.button.width or
        beautiful.button.width or
        dpi(70)
    , bg =
        bg_color or
        beautiful.bar.button.bg_color or
        beautiful.button.bg_color or
        beautiful.bg_color
    , widget = wibox.container.background
    , shape =
        beautiful.bar.button.shape or
        beautiful.button.shape or
        gears.shape.rectangle() }

  section:connect_signal("mouse::enter", function ()
    section.bg =
      hover_color or
      beautiful.bar.button.hover_color or
      beautiful.button.hover_color or
      beautiful.hover_color end )
  section:connect_signal("mouse::leave", function ()
    section.bg =
      bg_color or
      beautiful.bar.button.bg_color or
      beautiful.button.bg_color or
      beautiful.bg_color end )

  return section
end
