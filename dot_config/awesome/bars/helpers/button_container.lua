local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")

local button_container = function (widget, color, bg_color, hover_color)
  local section = wibox.widget
    { id = "background_widget"
    , widget = wibox.container.background
    , bg = bg_color or beautiful.xbackground
    , shape = function (cr, w, h) gears.shape.parallelogram(cr, w, h, w-h) end
    , { widget = wibox.container.margin
        , left = dpi(16)
        , right = dpi(16)
        , widget } }

  section:connect_signal
    ( "mouse::enter"
    , function ()
        section.bg = hover_color or beautiful.xbackground
      end )
  section:connect_signal
    ( "mouse::leave"
    , function ()
        section.bg = bg_color or beautiful.xbackground
      end )

  return section
end

return button_container
