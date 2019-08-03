local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

-- Theming transitions
local update_taglist = function (item, tag, index, _)
  item:get_children_by_id('name')[1].markup = not ( tag.name == "" ) and "<b>: "..tag.name.."</b>" or ""
  item:get_children_by_id('index')[1].markup = "<b>"..index.."</b>"
  if tag.selected then
    item.bg =
      beautiful.tag.colors.focused or
      beautiful.xcolor15
  end --[[elseif tag.urgent then
    item.bg =
      beautiful.tag.colors.urgent or
      beautiful.xcolor9
  elseif #tag:clients() > 0 then
    item.bg =
      beautiful.tag.colors.occupied_i[index] or
      beautiful.tag.colors.occupied or
      beautiful.xcolor0
  else
    item.bg =
      beautiful.tag.colors.empty_i[index] or
      beautiful.tag.colors.empty or
    beautiful.xcolor1 end ]]
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
