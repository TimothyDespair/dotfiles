local cairo = require("lgi").cairo
local gears = require("gears")

return function (c1, c2, c3)
  local w = dpi(300)
  local h = dpi(50)

  local img = cairo.ImageSurface.create(cairo.Format.ARGB8, w, h)
  local cr = cairo.Context(img)

  gears.shape.transform
  ( gears.shape.parallelogram )
    : translate(dpi(100), 0)
  ( cr, dpi(200), h, dpi(150) )
  cr:set_source_rgba(gears.color.parse_color(c1.."ff"))
  cr:fill()

  gears.shape.transform
  ( gears.shape.parallelogram )
    : translate(0, 0)
  ( cr, dpi(200), h, dpi(150) )
  cr:set_source_rgba(gears.color.parse_color(c2.."ff"))
  cr:fill()

  gears.shape.transform
  ( gears.shape.parallelogram )
    : translate(-dpi(100), 0)
  ( cr, dpi(200), h, dpi(150) )
  cr:set_source_rgba(gears.color.parse_color(c3.."ff"))
  cr:fill()

  return img
end
