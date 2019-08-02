local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")

local colorise_text = require("helpers/colorise_text")

local function get_theme_prop(name)
  if beautiful.bar then
    if beautiful.bar.button then
      return beautiful.bar.button[name]
    else return beatiful.bar[name] end
  else return beautiful[name] end end

local gtp = get_theme_prop

make_button = function (symbol, color, bg_color, hover_color, font, shape, width)
  local widget = wibox.widget
    { font = font or gtp("font")
    , align = "center"
    , id = "text_role"
    , valign = "center"
    , markup =
        colorise_text
          ( symbol
          , color or gtp("color") or beautiful.xcolor15 )
    , widget = wibox.widget.textbox() }

  local section = wibox.widget
    { widget
    , forced_width =
        width or
        beautiful.bar and
          ( beautiful.bar.button and
            beautiful.bar.button.width or
            beautiful.button.width ) or
        dpi(20)
    , bg = bg_color or gtp("bg_color")
    , widget = wibox.container.background
    , shape =
        beautiful.bar and
          ( beautiful.bar.button and
            beautiful.bar.button.shape or
            beautiful.button.shape ) or
        function (cr, width, height) gears.shape.rectangle(cr, width, height) end }

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

  return section end

return make_button
