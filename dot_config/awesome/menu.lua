local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local beautiful = require("beautiful")

local awesome_menu =
  { { "Hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end }
  , { "Restart",     awesome.restart }
  , { "Quit",        function() awesome.quit() end } }

local main_menu =
  awful.menu
    ( { items =
        { { "Awesome", awesome_menu, beautiful.awesome_icon }
        , { "Terminal", terminal } } } )

local menu_launcher =
  awful.widget.launcher
    ( { image = beautiful.launcher_icon
      , width = dpi(16)*4
      , menu  = main_menu } )

local transition_state = 0

local function ease(inout)
  if inout == "in" then
    if transition_state >= 0.9 then
      return false
    end
    transition_state = transition_state + 0.1
    menu_launcher:set_image(beautiful.launcher_icon_ease(transition_state))
    -- menu_launcher:emit_signal("widget::redraw_needed")
    return true
  else
    if transition_state <= 0.1 then
      return false
    end
    transition_state = transition_state - 0.1
    menu_launcher:set_image(beautiful.launcher_icon_ease(transition_state))
    -- menu_launcher:emit_signal("widget::redraw_needed")
    return true
  end
end

local timer

menu_launcher:connect_signal
  ( "mouse::enter"
  , function ()
      if timer then timer:stop() end
      timer = gears.timer.start_new(0.01, function () return ease("in") end)
    end )

menu_launcher:connect_signal
  ( "mouse::leave"
  , function ()
      if timer then timer:stop() end
      timer = gears.timer.start_new(0.01, function () return ease("out") end)
    end )

return
  { main_menu     = main_menu
  , menu_launcher = menu_launcher }
