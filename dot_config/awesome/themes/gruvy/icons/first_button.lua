local gears = require("gears")
local cairo = require("lgi").cairo

return function (color)
  local w = dpi(125)
  local h = dpi(50)

  local img = cairo.ImageSurface.create(cairo.Format.ARGB80, w, h)
  local cr = cairo.Context(img)

  cr:set_source_rgba(gears.color.parse_color(color.."ff"))
  gears.shape.transform
  ( gears.shape.parallelogram )
    : translate(-h, 0)
  ( cr, w+h, h, w )
  cr:fill()

  return img
end
