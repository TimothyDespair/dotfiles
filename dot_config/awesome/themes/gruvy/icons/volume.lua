local gears = require("gears")
local cairo = require("lgi").cairo

return function (c1, c2, c3)
  return function (v)
    local w = dpi(50)
    local h = dpi(50)
    local p = dpi(2)
    
    local img = cairo.ImageSurface.create(cairo.Format.ARGB8, w, h)
    local cr = cairo.Context(img)

    gears.shape.transform
    ( gears.shape.octogon )
      : translate(p, p)
    ( cr, w-2*p, h-2*p, dpi(5) )
    cr:set_source_rgba(gears.color.parse_color(c1.."ff"))
    cr:fill()

    gears.shape.transform
    ( gears.shape.arc )
      : translate( dpi(5), dpi(5) )
    ( cr, w-dpi(10), h-dpi(10), dpi(15), 0, 2*math.pi )
    cr:set_source_rgba(gears.color.parse_color(c3.."ff"))
    cr:fill()
    
    gears.shape.transform
    ( gears.shape.arc )
      : translate( dpi(5), dpi(5) )
      : rotate_at(dpi(25), dpi(25), -math.pi/2 )
    ( cr, w-dpi(10), h-dpi(10), dpi(15), 0, (v/60)*math.pi )
    cr:set_source_rgba(gears.color.parse_color(c2.."ff"))
    cr:fill()
    
    return img
  end
end

    
