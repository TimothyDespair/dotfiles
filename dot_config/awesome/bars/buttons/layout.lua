local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local beautiful = require("beautiful")

local button_container = require("bars/helpers/button_container")

local layout = function(s)
  local widget = awful.widget.layoutbox(s)

  widget:buttons ( gears.table.join
    ( awful.button({ }, 1, function() awful.layout.inc( 1) end )
    , awful.button({ }, 3, function() awful.layout.inc(-1) end )
    , awful.button({ }, 4, function() awful.layout.inc( 1) end )
    , awful.button({ }, 5, function() awful.layout.inc(-1) end ) ) )

  return button_container(widget)
end

return layout
