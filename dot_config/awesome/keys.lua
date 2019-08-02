local awful = require("awful")
local gears = require("gears")

local hotkeys_popup = require("awful.hotkeys_popup")

local titlebars_on = true -- For tablet mode

local settings = require("settings")
local modkey = settings.modkey

local keys =
  gears.table.join
    ( awful.key
        ( { modkey,           }, "s",        hotkeys_popup.show_help
        , { description="Help",              group="Awesome" } )
    , awful.key
        ( { modkey,           }, "Left",     awful.tag.viewprev
        , { description = "+ Tag",           group = "Tag" } )
    , awful.key
        ( { modkey,           }, "Right",    awful.tag.viewnext
        , { description = "- Tag",           group = "Tag" } )
    , awful.key
        ( { modkey,           }, "Escape",   awful.tag.history.restore
        , { description = "Last Tag",        group = "Tag" } )
    , awful.key
        ( { modkey,           }, "j",        function () awful.client.focus.byidx( 1) end
        , { description = "+ Focus",         group = "Client" } )
    , awful.key
        ( { modkey,           }, "k",        function () awful.client.focus.byidx(-1) end
        , { description = "- Foucs",         group = "Client" } )
    , awful.key
        ( { modkey,           }, "w",        function () mymainmenu:show() end -- TODO
        , { description = "Main Menu",       group = "Awesome" } )
    -- Layout manipulation
    , awful.key
        ( { modkey, "Shift"   }, "j",        function () awful.client.swap.byidx(  1)    end
        , { description = "+ Swap Client",   group = "Client" } )
    , awful.key
        ( { modkey, "Shift"   }, "k",        function () awful.client.swap.byidx( -1)    end
        , { description = "- Swap Client",   group = "Client" } )
    , awful.key
        ( { modkey, "Control" }, "j",        function () awful.screen.focus_relative( 1) end
        , { description = "Next Screen",     group = "Screen" } )
    , awful.key
        ( { modkey, "Control" }, "k",        function () awful.screen.focus_relative(-1) end
        , { description = "Last Screen",     group = "Screen" } )
    , awful.key
        ( { modkey,           }, "u",        awful.client.urgent.jumpto
        , { description = "Urgent Client",   group = "Client" } )
    , awful.key
        ( { modkey,           }, "Tab"
        , function ()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end end
        , { description = "Last Client",     group = "Client" } )
    -- Standard program
    , awful.key
        ( { modkey,           }, "Return",   function () awful.spawn(settings.terminal) end
        , { description = "Terminal",        group = "Launcher" } )
    , awful.key
        ( { modkey, "Control" }, "r",        awesome.restart
        , { description = "Reload Awesome",  group = "Awesome" } )
    , awful.key
        ( { modkey, "Shift"   }, "q",        awesome.quit
        , { description = "Quit Awesome",    group = "Awesome" } )
    , awful.key
        ( { modkey,           }, "l",        function () awful.tag.incmwfact( 0.05)          end
        , { description = "+ Master Width",  group = "Layout" } )
    , awful.key
        ( { modkey,           }, "h",        function () awful.tag.incmwfact(-0.05)          end
        , { description = "- Master Width",  group = "Layout" } )
    , awful.key
        ( { modkey, "Shift"   }, "h",        function () awful.tag.incnmaster( 1, nil, true) end
        , { description = "+ Master #",      group = "Layout" } )
    , awful.key
        ( { modkey, "Shift"   }, "l",        function () awful.tag.incnmaster(-1, nil, true) end
        , { description = "- Master #",      group = "Layout" } )
    , awful.key
        ( { modkey, "Control" }, "h",        function () awful.tag.incncol( 1, nil, true)    end
        , { description = "+ Column #",      group = "Layout" } )
    , awful.key
        ( { modkey, "Control" }, "l",  	     function () awful.tag.incncol(-1, nil, true)    end
        , { description = "- Column #",      group = "Layout" } )
    , awful.key
        ( { modkey,           }, "space",    function () awful.layout.inc( 1)                end
        , { description = "Next Layout",     group = "Layout" } )
    , awful.key
        ( { modkey, "Shift"   }, "space",    function () awful.layout.inc(-1)                end
        , { description = "Last Layout",     group = "Layout" } )
    , awful.key
        ( { modkey, "Control" }, "n"
        , function ()
            local c = awful.client.restore()
            if c then c:emit_signal ( "request::activate", "key.unminimize", { raise = true } ) end end
        , { description = "Un-Minimise",     group = "Client" } )
    -- Prompt
    , awful.key
        ( { modkey },            "r",        function () awful.screen.focused().mypromptbox:run() end
        , { description = "Prompt",          group = "Launcher" } )
    , awful.key
        ( { modkey }, "x"
        , function ()
            awful.prompt.run
              { prompt       = "Run Lua code: "
              , textbox      = awful.screen.focused().prompt.widget
              , exe_callback = awful.util.eval
              , history_path = awful.util.get_cache_dir() .. "/history_eval" } end
        , { description = "Lua Prompt",      group = "Awesome" } )
    -- Menubar
    , awful.key
        ( { modkey }, "p", function() menubar.show() end
        , { description = "Show Menubar",    group = "Launcher" } )
    -- Titlebars
    , awful.key
        ( { modkey, "Shift" }, "t"
        , function ()
            if titlebars_on then
              for _, c in ipairs(client.get()) do
                awful.titlebar(c, {size = dpi(0)}) end
              titlebars_on = false
            else
              for _, c in ipairs(client.get()) do
                awful.titlebar(c, {size = dpi(16)}) end
              titlebars_on = true end end
    , { decription = "Toggle Titlebars",  group = "Client" } ) )

    for i = 1, 6 do
        keys =
          gears.table.join
            ( keys
            -- View tag only.
            , awful.key
                ( { modkey }, "#" .. i + 9
                , function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then tag:view_only() end end
                , { description = "View Tag #"..i,          group = "Tag" } )
            -- Toggle tag display.
            , awful.key
                ( { modkey, "Control" }, "#" .. i + 9
                , function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then awful.tag.viewtoggle(tag) end end
                , { description = "Toggle Tag #" .. i,      group = "Tag" } )
            -- Move client to tag.
            , awful.key
                ( { modkey, "Shift" }, "#" .. i + 9
                , function ()
                    if client.focus then
                      local tag = client.focus.screen.tags[i]
                      if tag then client.focus:move_to_tag(tag) end end end
                , { description = "Move to Tag #"..i,       group = "Tag" } )
            -- Toggle tag on focused client.
            , awful.key
                ( { modkey, "Control", "Shift" }, "#" .. i + 9
                , function ()
                    if client.focus then
                      local tag = client.focus.screen.tags[i]
                      if tag then client.focus:toggle_tag(tag) end end end
                , { description = "Toggle in Tag #" .. i,   group = "Tag" } ) ) end

return keys
