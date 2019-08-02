local awful = require("awful")

return
  gears.table.join
    ( awful.key
        ( { modkey,           }, "f"
        , function (c)
            c.fullscreen = not c.fullscreen
            c:raise() end
        , { description = "Fullscreen",      group = "Client" } )
    , awful.key
        ( { modkey, "Shift"   }, "c",        function (c) c:kill()                         end
        , { description = "Close",           group = "Client" } )
    , awful.key
        ( { modkey, "Control" }, "space",    awful.client.floating.toggle
        , { description = "toggle floating", group = "Client" } )
    , awful.key
        ( { modkey, "Control" }, "Return",   function (c) c:swap(awful.client.getmaster()) end
        , { description = "Move to Master",  group = "Client" } )
    , awful.key
        ( { modkey,           }, "o",        function (c) c:move_to_screen()               end
        , { description = "Move to Screen",  group = "Client" } )
    , awful.key
        ( { modkey,           }, "t",        function (c) c.ontop = not c.ontop            end
        , { description = "Keep on Top",     group = "Client" } )
    , awful.key
        ( { modkey,           }, "n",        function (c) c.minimized = true               end
        , { description = "Minimize",        group = "Client" } )
    , awful.key
        ( { modkey,           }, "m"
        , function (c)
            c.maximized = not c.maximized
            c:raise() end
        , { description = "Maximize",        group = "Client" } )
    , awful.key
        ( { modkey, "Control" }, "m"
        , function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise() end
        , { description = "Maximise (V)",    group = "Client" } )
    , awful.key
        ( { modkey, "Shift"   }, "m"
        , function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise() end
        , { description = "Maximise (H)",    group = "Client" } ) )