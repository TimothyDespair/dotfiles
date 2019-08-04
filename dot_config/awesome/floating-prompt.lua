local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local naughty = require("naughty")

local post_error = require("post-error")

return function (s)
  local res, err = pcall(awful.popup({
    ontop = true,
    screen = s,
    forced_width = dpi(400),
    bg = beautiful.prompt_wibox_bg or beautiful.bg_normal or beautiful.xbackground,
    shape = function (cr, width, height)
      gears.shape.rounded_rect(cr, width, height, dpi(5))
    end,
    widget =  ({
      layout = wibox.layout.fixed.vertical,
      forced_width = dpi(400),
      {
        widget = wibox.container.background,
        layout = wibox.layout.fixed.vertical,
        bg = beautiful.prompt_wibox_bg,
        awful.widget.prompt,
      },
    }),
  }))
  if err then
    post_error(err)
    return nil
  end
  return res
end
