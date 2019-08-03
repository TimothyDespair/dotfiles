local cairo = require("lgi").cairo
local gears = require("gears")

return function (c1, c2, c3)
  local w = dpi(50)
  local h = dpi(50)

  local img = cairo.ImageSurface.create(cairo.Format.ARGB8, w, h)
  local cr = cairo.Context(img)

  cr:set_source_rgba(gears.color.parse_color(c1.."ff"))
  cr:paint()


  gears.shape.transform
  ( gears.shape.parallelogram )
    : translate(-2*w/3, 0)
    ( cr, (2*w), h, w )
  cr:set_source_rgba(gears.color.parse_color(c2.."ff"))
  cr:fill()

  gears.shape.transform
  ( gears.shape.parallelogram )
    : translate(-4*w/3, 0)
  ( cr, (2*w), h, w )
  cr:set_source_rgba(gears.color.parse_color(c3.."ff"))
  cr:fill()

  return img
end
