-- Theming transitions
local update_taglist = function (item, tag, index)
  if tag.selected then
    item.bg =
      beautiful.tag.colors.focused or
      beautiful.xcolor15
  elseif tag.urgent then
    item.bg =
      beautiful.tag.colors.urgent or
      beautiful.xcolor9
  elseif #tag:client() > 0 then
    item.bg =
      beautiful.tag.colors.occupied_i[index] or
      beautiful.tag.colors.occupied
  else
    item.bg = beautiful.tag.colors.empty_i[index] or
    beautiful.tag.colors.empty end end

local taglist = function(s)
  -- Create a Taglist for Screen
  awful.widget.taglist
    { screen = s
    , filter = awful.widget.taglist.filter.all
    , buttons = 
        gears.table.join
          ( awful.button({ },        1, function (t) t:view_only() end)
          , awful.button({ modkey }, 1, function (t) if client.focus then client.focus:move_to_tag(t) end end )
          , awful.button({ },        3, awful.tag.viewtoggle)
          , awful.button({ modkey }, 3, function (t) if client.focus then client.focus:toggle_tag(t) end end )
          , awful.button({ },        4, function (t) awful.tag.viewnext(t.screen) end )
          , awful.button({ },        5, function (t) awful.tag.viewprev(t.screen) end ) )
    , layout = wibox.layout.flex.horizontal
    , widget_template =
      { widget = wibox.container.background
      , create_callback = function(self, tag, index, _)
          update_taglist(self, tag, index) end
      , update_callback = function(self, tag, index, _)
          update_taglist(self, tag, index) end } } end

return taglist
