local gears = require("gears")
local cairo = require("lgi").cairo

return function (color)
  local w = dpi(150)
  local h = dpi(50)

  local img = cairo.ImageSurface.create(cairo.Format.ARGB80, w, h)
  local cr = cairo.Context(img)

  cr:set_source_rgba(gears.color.parse_color(color.."ff"))
  gears.shape.parallelogram(cr, w, h, w-h)
  cr:fill()

  return img
end
