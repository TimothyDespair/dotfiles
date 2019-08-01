local mpc = require("widgets/utils/mpc")
local wibox = require("wibox")
local timer = require("gears.timer")

local mpd_text = wibox.widget.textbox ()

local mpd_widget =
  wibox.widget
    { align = 'center'
    , widget = mpd_text }
    
local state, title, artist, file = "stop", "", "", ""

local function update_widget()
  local text = "Playing: "
  text = text .. tostring ( artist or "" ) .. " - " .. tostring ( title or "" )
  if state == "pause" then
    text = text .. " (||)"
  end
  if state == "stop" then
    text = text .. " ([])"
  end
  mpd_text.text = text
end

local connection
local function error_handler ( err )
  mpd_widget:set_text ( "Error: " .. tostring ( err ) )
  -- Try a reconnect soon-ish
  timer.start_new
    ( 10
    , function () connection:send ( "ping" ) end ) end
    
connection =
  mpc.new
    ( nil, nil, nil, error_handler
    , "status"
    , function ( _, result ) state = result.state end
    , "currentsong"
    , function ( _, result )
        title, artist, file = result.title, result.artist, result.file
        pcall ( update_widget ) end )
        
return mpd_widget

