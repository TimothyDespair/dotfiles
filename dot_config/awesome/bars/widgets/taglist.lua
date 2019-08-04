local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local naughty = require("naughty")

local beautiful = require("beautiful")

-- State
local update_taglist = function (item, tag, index, _)
  local res, err = pcall( function ()
      local color =
        beautiful.tag and
        beautiful.tag.font_color or
        beautiful.xforeground
    if tag.selected then
      item:get_children_by_id('name')[1].markup =
        " <span foreground='"..color.."'><b>"..index..(tag.name and ":"..tag.name or "" ).." </b></span>"
    else
      item:get_children_by_id('name')[1].markup =
        " <span foreground='"..color.."'>"..index..(tag.name and ":"..tag.name or "" ).."</span> "
    end
    if #tag.clients(tag) > 0 then
      item.bg =
        beautiful.tag and
        ( beautiful.tag.colors and
          beautiful.tag.colors[(index-1)%6+1] or
          beautiful.tag.color ) or
        beautiful["xcolor"..(index-1)%6 + 1]
    else
      item.bg =
        beautiful.tag and
        beautiful.tag.empty_color or
        beautiful["xcolor8"]
    end
  end )
  if err then
    naughty.notify({text = err})
  end
end

local parallelogram = function(cr, width, height)
  gears.shape.parallelogram(cr, width, height, width-height)
end

local taglist_buttons =
  gears.table.join
    ( awful.button({ },        1, function (t) t:view_only() end)
    , awful.button({ modkey }, 1, function (t) if client.focus then client.focus:move_to_tag(t) end end )
    , awful.button({ },        3, awful.tag.viewtoggle)
    , awful.button({ modkey }, 3, function (t) if client.focus then client.focus:toggle_tag(t) end end )
    , awful.button({ },        4, function (t) awful.tag.viewnext(t.screen) end )
    , awful.button({ },        5, function (t) awful.tag.viewprev(t.screen) end ) )

local taglist = function(s)
  -- Create a Taglist for Screen
  local taglist =  awful.widget.taglist
    { screen = s
    , filter = awful.widget.taglist.filter.all
    , buttons = taglist_buttons
    , layout =
      { spacing = -dpi(17)
      , layout = wibox.layout.flex.horizontal }
    , widget_template =
      { id = "button"
      , widget = wibox.container.background
      , shape = parallelogram
      , forced_width = dpi(120)
      , { widget = wibox.container.margin
        , left = dpi(16)
        , right = dpi(16)
        , { id = "name"
          , align = "center"
          , valign = "center"
          , widget = wibox.widget.textbox } }
      , create_callback = update_taglist
      , update_callback = update_taglist } }
  return taglist
end

return taglist
