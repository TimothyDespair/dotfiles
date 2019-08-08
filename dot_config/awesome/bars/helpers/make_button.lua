local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")

local colorise_text = require("helpers/colorise_text")

local function get_theme_prop(name)
  return
    beautiful.bar and
    ( beautiful.bar.button and
      beautiful.bar.button[name] or
      beautiful.bar[name] ) or
    beautiful[name] or error("No value for "..name.." found in theme") end

local gtp = get_theme_prop

local make_button = function (image, color, bg_color, hover_color, font, width)
  local widget = wibox.widget
    { font = font or gtp("font")
    , id = "text_role"
    , image = image
    , widget = wibox.widget.imagebox }

  local section = wibox.widget
    { widget = wibox.container.background
    , bg = bg_color or gtp("bg_color")
    , shape = function (cr, w, h) gears.shape.parallelogram(cr, w, h, w-h) end
    , { widget = wibox.container.margin
        , left = dpi(16)
        , right = dpi(16)
        , widget } }

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
