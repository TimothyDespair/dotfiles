local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local keys = require("keys")

local launcher = require("menu").menu_launcher
local volume = require("bars/buttons/volume")
local bin_clock = require("bars/buttons/bin-clock")
local layout = require("bars/buttons/layout")
local taglist = require("bars/widgets/taglist")

local attach_bar = function(s)
  s.taglist =
    --awful.widget.taglist {screen = s, filter = awful.widget.taglist.filter.all}
    taglist(s)
  -- s.layout_button = {}
  s.promptbox = awful.widget.prompt()

  s.wibox = awful.wibar(
    { visible = true
    , ontop = true
    , type = "dock"
    , position = "top"
    , bg = beautiful.bar and beautiful.bar.bg_color or beautiful.bg_color
    , height = beautiful.bar and beautiful.bar.height or dpi(26) } )

  s.wibox:setup
    { layout = wibox.layout.align.horizontal
    , expand = "outside"
    , { layout = wibox.layout.fixed.horizontal
      , launcher
      , s.promptbox
      --[[ TODO Music ]] }
    , s.taglist
    , { layout = wibox.layout.align.horizontal
        , { layout = wibox.layout.align.horizontal }
        , { layout = wibox.layout.align.horizontal }
        , { layout = wibox.layout.align.horizontal
          -- VPN,
          -- WIFI,
          , volume
        -- BATTERY,
          , bin_clock
        --[[ , s.layout_button]] } } }

  -- awful.placement.maximize_horizontally(s.wibox) end
end
return attach_bar
