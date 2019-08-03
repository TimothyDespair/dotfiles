local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local beautiful = require("beautiful")

-- State
local update_taglist = function (item, tag, index, _)
  if tag.selected then
    item:get_children_by_id('name')[1].markup = not ( tag.name == "" ) and "<b>: "..tag.name.."</b>" or ""
    item:get_children_by_id('index')[1].markup = "<b>"..index.."</b>"
  else
    item:get_children_by_id('name')[1].markup = not ( tag.name == "" ) and tag.name or ""
    item:get_children_by_id('index')[1].markup = index
  end
  if #tag.clients() > 0 then
    item.bg =
      beautiful.tag and
      ( beautiful.tag.colors and
        beautiful.tag.colors[0] or
        beautiful.tag.color ) or
      beautiful["xcolor"..(index+8)%6]
  else
    item.bg =
      beautiful.tag and
      beautiful.tag.empty_color or
      beautiful["xcolor8"]
  end
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
    , widget_template =
      { id = "background_role"
      , widget = wibox.container.background
      , { layout = wibox.layout.fixed.horizontal,
          { id = "index"
          , widget = wibox.widget.textbox }
        , { id = "name"
            , widget = wibox.widget.textbox } }
      , create_callback = update_taglist
      , update_callback = update_taglist } }
  return taglist
end

return taglist
