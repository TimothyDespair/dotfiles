local hotkeys_popup = require("awful.hotkeys_popup").widget

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
      , menu  = main_menu } )

return
  { main_menu     = main_menu
  , menu_launcher = menu_launcher }