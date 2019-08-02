local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")

local colorise_text = require("helpers/colorise_text")

make_button = function (symbol, color, bg_color, hover_color, font, shape, width)
  local widget = wibox.widget {
    font = font or beautiful.bar.button.font or beautiful.bar.font or beautiful.font,
    align = "center",
    id = "text_role",
    valign = "center",
    markup = colorise_text(symbol, color or beautiful.bar.button.color or beautiful.bar.color or beautiful.color),
    widget = wibox.widget.textbox(),
  }

  local section = wibox.widget {
    widget,
    forced_width = width or beautiful.bar.button.width or beautiful.button.width or dpi(70),
    bg = bg_color or beautiful.bar.button.bg_color or beautiful.button.bg_color or beautiful.bg_color,
    widget = wibox.container.background,
    shape = beautiful.bar.button.shape or beautiful.button.shape or gears.shape.rectangle(),
  }

  section:connect_signal("mouse::enter", function ()
    section.bg = hover_color or beautiful.bar.button.hover_color or beautiful.button.hover_color or beautiful.hover_color
  end)
  section:connect_signal("mouse::leave", function ()
    section.bg = bg_color or beautiful.bar.button.bg_color or beautiful.button.bg_color or beautiful.bg_color
  end)

  return section
end

return make_button
