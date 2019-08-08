local cairo = require("lgi").cairo
local gears = require("gears")

return function (c1, c2, c3, c4, c5, c6)
  return function (t)
    local w = dpi(300)
    local h = dpi(50)
    local e = dpi(t * 300)
    local s = w/3
  
    local img = cairo.ImageSurface.create(cairo.Format.ARGB8, w, h)
    local cr = cairo.Context(img)

    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(-h, 0)
    ( cr, w+h, h, w )
    cr:clip()
    
    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(s+e, 0)
    ( cr, dpi(200), h, dpi(150) )
    cr:set_source_rgba(gears.color.parse_color(c1.."ff"))
    cr:fill()
  
    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(e, 0)
    ( cr, dpi(200), h, dpi(150) )
    cr:set_source_rgba(gears.color.parse_color(c2.."ff"))
    cr:fill()
  
    gears.shape.transform
    ( gears.shape.parallelogram )
       : translate(-s+e, 0)
    ( cr, dpi(200), h, dpi(150) )
    cr:set_source_rgba(gears.color.parse_color(c3.."ff"))
    cr:fill()
  
    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(-(2*s)+e, 0)
    ( cr, dpi(200), h, dpi(150) )
    cr:set_source_rgba(gears.color.parse_color(c4.."ff"))
    cr:fill()
  
    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(-(3*s)+e, 0)
    ( cr, dpi(200), h, dpi(150) )
    cr:set_source_rgba(gears.color.parse_color(c5.."ff"))
    cr:fill()
  
    gears.shape.transform
    ( gears.shape.parallelogram )
       : translate(-(4*s)+e, 0)
    ( cr, dpi(200), h, dpi(150) )
    cr:set_source_rgba(gears.color.parse_color(c6.."ff"))
    cr:fill()
  
    return img
  end
end
