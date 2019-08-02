--[[
Awesome 4.3 RC
  @TimothyDespair

With inspiration from @elenapan
]]

local themes = {
  "gruvy",      -- 1 --
}

local active_theme = themes[1]

--------------------------------------------------------------------------------

local bar_themes = {
  "gruvy",      -- 1 --
}

local active_bar_theme = bar_themes[1]

--------------------------------------------------------------------------------

-- TODO Icon themes.

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- THEMES

local beautiful = require("beautiful")
local theme_dir = os.getenv("HOME") .. ".config/awesome/themes/"

beautiful.init( theme_dir .. theme_name .. "/theme.lua" )

local xresources = require("beautiful.xresources")

dpi = xresources.apply_dpi

--------------------------------------------------------------------------------
-- AWESOME
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
require("awful.autofocus")

local naughty = require("naughty")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")

--------------------------------------------------------------------------------
-- LUAROCKS
pcall(require, "luarocks.loader")

--------------------------------------------------------------------------------
-- ERRORS
-- Startup Errors
if awesome.startup_errors then
  naughty.notify
    ( { preset = naughty.config.presets.critical
      , title  = "There were errors during startup. What did you break?"
      , text   = awesome.startup_errors } )
end

-- Runtime Errors
do
  local in_error = false
  awesome.connect_signal
    ( 'debug::error'
    , function (err)
        if in_eror then return end
        in_error = true

        naughty.notify
          ( { preset = naughty.config.presets.critical
            , title  = "There was a runtime error. What did you break?"
            , text   = toString(err) } )
        in_error = false end ) end
-- ERRORS }}}

--------------------------------------------------------------------------------
-- QUICK SETTINGS

terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

--------------------------------------------------------------------------------
-- LAYOUTS
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}


local titlebars_on = true -- For tablet mode



--------------------------------------------------------------------------------
-- MENU
-- Create a launcher widget and a main menu
myawesomemenu =
  { { "Hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end }
  , { "Restart",     awesome.restart }
  , { "Quit",        function() awesome.quit() end } }

mymainmenu =
  awful.menu
    ( { items =
        { { "Awesome", myawesomemenu, beautiful.awesome_icon }
	, { "Terminal", terminal } } } )

mylauncher =
  awful.widget.launcher
    ( { image = beautiful.awesome_icon
      , menu = mymainmenu } )

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Adapted from streetturtle/awesome-wm-widgets
mybattery = awful.widget.watch
  ( "acpi", 10
  , function ( widget, stdout )
      for s in stdout:gmatch("[^\r\n]+") do
        function error (msg)
          naughty.notify({text = msg}) end
        local words = {}
        for w in string.gmatch(s, '%S+') do
          table.insert(words, w) end
        local status = words[3]
        local source = ( status == "Discharging," ) and "BAT" or "AC"
        local percent = string.gsub ( words[4], ",", "" )
        local timeleft = "Done"
        if words[5] then
          timeleft = words[5] end
        widget:set_text( percent .. source .. "(" .. timeleft .. ")" )
        return end end )

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ WIBAR
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %a %d %b %H%M ")

-- Create a wibox for each screen and add it
local taglist_buttons =
  gears.table.join
    ( awful.button({ },        1, function (t) t:view_only() end)
    , awful.button({ modkey }, 1, function (t) if client.focus then client.focus:move_to_tag(t) end end )
    , awful.button({ },        3, awful.tag.viewtoggle)
    , awful.button({ modkey }, 3, function (t) if client.focus then client.focus:toggle_tag(t) end end )
    , awful.button({ },        4, function (t) awful.tag.viewnext(t.screen) end )
    , awful.button({ },        5, function (t) awful.tag.viewprev(t.screen) end ) )

local tasklist_buttons =
  gears.table.join
    ( awful.button
        ( { }, 1
        , function (c)
            if c == client.focus then
              c.minimized = true
            else
              c:emit_signal("request::activate", "tasklist", { raise = true } ) end end )
    , awful.button({ }, 3, function () awful.menu.client_list ( { theme = { width = 250 } } ) end )
    , awful.button({ }, 4, function () awful.client.focus.byidx (1) end )
    , awful.button({ }, 5, function () awful.client.focus.byidx (-1) end ) )
-- WIBAR }}}

-- {{{ SCREENS
local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
    gears.wallpaper.maximized(wallpaper, s, true) end end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- local mpd_widget = require('widgets/mpd')

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons
    ( gears.table.join
        ( awful.button({ }, 1, function () awful.layout.inc( 1) end )
        , awful.button({ }, 3, function () awful.layout.inc(-1) end )
        , awful.button({ }, 4, function () awful.layout.inc( 1) end )
        , awful.button({ }, 5, function () awful.layout.inc(-1) end ) ) )
	
  -- Create a taglist widget
  s.mytaglist =
    awful.widget.taglist
      { screen  = s
      , filter  = awful.widget.taglist.filter.all
      , buttons = taglist_buttons }

  -- Create a tasklist widget
  s.mytasklist =
    awful.widget.tasklist 
      { screen  = s
      , filter  = awful.widget.tasklist.filter.currenttags
      , buttons = tasklist_buttons }
  
  -- Create the wibox
  s.mywibox = awful.wibar ( { position = "top", screen = s, height = dpi(16) } )

  -- Add widgets to the wibox
  s.mywibox:setup
    { layout = wibox.layout.align.horizontal
    , { layout = wibox.layout.fixed.horizontal -- LHS Widgets
      , mylauncher
      , s.mytaglist }
    --, s.mytasklist -- Middle widget
    , s.mypromptbox
    --, mpd_widget
    , { layout = wibox.layout.fixed.horizontal -- RHS Widgets
      , mybattery
      , mytextclock
      , s.mylayoutbox } } end )
-- SCREENS }}}

-- {{{ MOUSE
root.buttons
  ( gears.table.join
      ( awful.button ( { }, 3, function () mymainmenu:toggle() end)
      , awful.button ( { }, 4, awful.tag.viewnext )
      , awful.button ( { }, 5, awful.tag.viewprev ) ) )
-- MOUSE }}}

-- {{{ KEYS
globalkeys =
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
        ( { modkey,           }, "w",        function () mymainmenu:show() end
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
        ( { modkey,           }, "Return",   function () awful.spawn(terminal) end
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
              , textbox      = awful.screen.focused().mypromptbox.widget
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
                
              
            

clientkeys =
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

-- Bind all key numbers to tags.
for i = 1, 9 do
  globalkeys =
    gears.table.join
      ( globalkeys
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

clientbuttons =
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

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules =
  { { rule = { } -- All clients will match this rule.
    , properties =
        { border_width = beautiful.border_width
        , border_color = beautiful.border_normal
        , focus = awful.client.focus.filter
        , raise = true
        , keys = clientkeys
        , buttons = clientbuttons
        , screen = awful.screen.preferred
        , placement = awful.placement.no_overlap+awful.placement.no_offscreen } }
  , { rule_any = -- Floating clients.
        { instance =
            { "DTA"  -- Firefox addon DownThemAll.
            , "copyq"  -- Includes session name in class.
            , "pinentry" }
        , class =
            { "Arandr"
            , "Blueman-manager"
            , "Gpick"
            , "Kruler"
            , "MessageWin"  -- kalarm.
            , "Sxiv"
            , "Tor Browser" -- Needs a fixed window size to avoid fingerprinting by screen size.
            , "Wpa_gui"
            , "veromix"
            , "xtightvncviewer" }
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        , name = { "Event Tester" }  -- xev.
        , role =
            { "AlarmWindow"  -- Thunderbird's calendar.
            , "ConfigManager"  -- Thunderbird's about:config.
            , "pop-up" } }       -- e.g. Google Chrome's (detached) Developer Tools.
    , properties = { floating = true } }
  , { rule_any = -- Add titlebars to normal clients and dialogs
      { type = { "normal", "dialog" } }
    , properties = { titlebars_enabled = true } } }
    
-- Set Firefox to always map on the tag named "2" on screen 1.
-- { rule = { class = "Firefox" },
--   properties = { screen = 1, tag = "2" } },
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
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
      local size = titlebars_on and 16 or 0
      awful.titlebar(c, { size = dpi(size) } ) : setup
        { { buttons = buttons -- LHS
          , layout  = wibox.layout.fixed.horizontal }
        , { { align  = "center" -- MIDDLE
            , widget = awful.titlebar.widget.titlewidget(c) }
          , buttons = buttons
          , layout  = wibox.layout.flex.horizontal }
        , { awful.titlebar.widget.floatingbutton (c) --RHS
          , awful.titlebar.widget.maximizedbutton(c)
          , awful.titlebar.widget.stickybutton   (c)
          , awful.titlebar.widget.ontopbutton    (c)
          , awful.titlebar.widget.closebutton    (c)
          , layout = wibox.layout.fixed.horizontal() }
        , layout = wibox.layout.align.horizontal } end )

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal
  ( "mouse::enter"
  , function(c) c:emit_signal ( "request::activate", "mouse_enter", { raise = false } ) end )

client.connect_signal ( "focus", function(c) c.border_color = beautiful.border_focus end )
client.connect_signal ( "unfocus", function(c) c.border_color = beautiful.border_normal end )
-- }}}

