local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local beautiful = require("beautiful")

local button_container = require("bars/helpers/button_container")

local clock_color       = beautiful.xcolor8
local clock_hover_color = beautiful.xcolor13
local clock_icon        = beautiful.clock_icon

local init_t = os.date("*t")

local clock = wibox.widget
  { image = clock_icon(0, 0)
  , widget = wibox.widget.imagebox }

local minutes_cache = 0

clock.timer = gears.timer
  { autostart = true
  , timeout = 1
  , callback = function()
      local res, err = pcall(function()
        local t = os.date("*t")
        if t.min ~= minutes_cache then	    
          clock:set_image
	    ( clock_icon(t.hour, t.min) )
	  minutes_cache = t.min
	end
      end )
      if err then naughty.notify({text = "Clock Error: "..err}) end
      return true
    end }
  
local button = button_container(clock, clock_color, clock_hover_color) 
  
return button
 
