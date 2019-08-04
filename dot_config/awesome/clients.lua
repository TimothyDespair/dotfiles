local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local beautiful = require("beautiful")

local clientkeys = require("clientkeys")

local clientbuttons =
  gears.table.join
    ( awful.button
        ( { }, 1
        , function (c) c:emit_signal("request::activate", "mouse_click", { raise = true } ) end )
    , awful.button
        ( { modkey }, 1
        , function (c)
            c:emit_signal("request::activate", "mouse_click", { raise = true } )
            awful.mouse.client.move(c) end )
    , awful.button
        ( { modkey }, 3
        , function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c) end ) )

client.connect_signal
  ( "manage"
  , function (c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      if not awesome.startup then awful.client.setslave(c) end
      if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
          -- Prevent clients from being unreachable after screen count changes.
          awful.placement.no_offscreen(c) end end )

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal
  ( "request::titlebars"
  , function(c)
      c.shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, dpi(5))
      end

      local ret, err = pcall(function()
      local buttons =
        gears.table.join
          ( awful.button
              ( { }, 1
              , function()
                  c:emit_signal("request::activate", "titlebar", { raise = true } )
                  awful.mouse.client.move(c) end )
          , awful.button
              ( { }, 3
              , function()
                  c:emit_signal("request::activate", "titlebar", { raise = true } )
                  awful.mouse.client.resize(c) end ) )

      local size = dpi(16)

      awful.titlebar(c, { size = size } ) : setup
        { layout = wibox.layout.align.horizontal
        , { layout = wibox.layout.fixed.horizontal -- LHS
          , spacing = -dpi(17)
          , awful.titlebar.widget.floatingbutton (c)
          , awful.titlebar.widget.stickybutton   (c)
          , awful.titlebar.widget.ontopbutton    (c) }
        , { align  = "center" -- MIDDLE
          , buttons = buttons
          , widget = awful.titlebar.widget.titlewidget(c) }
        , { layout = wibox.layout.fixed.horizontal
          , spacing = -dpi(17)
          , awful.titlebar.widget.minimizebutton (c)
          , awful.titlebar.widget.maximizedbutton(c)
          , awful.titlebar.widget.closebutton    (c) } }
      end )
      if err then
        naughty.notify({text = err})
      end
    end )

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal
  ( "mouse::enter"
  , function(c) c:emit_signal ( "request::activate", "mouse_enter", { raise = false } ) end )

client.connect_signal ( "focus", function(c) c.border_color = beautiful.border_focus end )
client.connect_signal ( "unfocus", function(c) c.border_color = beautiful.border_normal end )
-- }}}

