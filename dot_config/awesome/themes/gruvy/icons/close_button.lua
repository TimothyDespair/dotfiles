local gears = require("gears")
local cairo = require("lgi").cairo

return function (color)
  local w = dpi(125)
  local h = dpi(50)

  local img = cairo.ImageSurface.create(cairo.Format.ARGB80, w, h)
  local cr = cairo.Context(img)

  cr:set_source_rgba(gears.color.parse_color(color.."ff"))
  gears.shape.parallelogram(cr, 2*w, h, 2*w-h)
  cr:fill()

  return img
end
