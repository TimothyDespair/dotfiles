local gears = require("gears")
local cairo = require("lgi").cairo

return function (c1, c2, c3, bg)
  return function (s)
    local h = s.geometry.height
    local w = s.geometry.width

    local p_base = h/10
    local p_bw = p_base + 5
    local p_h = h/2
    local p_w = p_h + p_base
    local p_wb = p_w + 5

    local img = cairo.ImageSurface.create(cairo.Format.RGB8, w, h)
    local cr = cairo.Context(img)

    cr:set_source_rgb(gears.color.parse_color(bg))
    cr:paint()

    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(w - 4 * p_base, h - p_h)
      ( cr, p_wb, p_h, p_bw )
    cr:set_source_rgba(gears.color.parse_color(c3))
    cr:fill()

    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(w - 3 * p_base, h - p_h)
    ( cr, p_wb, p_h, p_bw )
    cr:set_source_rgba(gears.color.parse_color(c2))
    cr:fill()

    gears.shape.transform
    ( gears.shape.parallelogram )
      : translate(w - 2 * p_base, h - p_h)
    ( cr, p_w, p_h, p_base )
    cr:set_source_rgba(gears.color.parse_color(c1))
    cr:fill()

    return img
  end
end

