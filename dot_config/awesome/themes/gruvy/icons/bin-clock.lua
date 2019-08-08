local cairo = require("lgi").cairo
local gears = require("gears")

return function (c1, c2)
  return function (H, M)
    local w = dpi(150)
    local h = dpi(50)
    local p = dpi(2)
    local s = (h/2)-2*p

    local Hs = {}
    local i = 1
    while i <= 5 do
      Hs[i] = H % 2
      H = (H - Hs[i]) / 2
      i = i + 1
    end

    local Ms = {}
    i = 1
    while i <= 6 do
      Ms[i] = M % 2
      M = (M - Ms[i]) / 2
      i = i + 1
    end

    local img = cairo.ImageSurface.create(cairo.Format.ARGB8, w, h)
    local cr = cairo.Context(img)

    for j, v in ipairs(Hs) do
      gears.shape.transform
      ( gears.shape.rectangle )
	: translate(w-(s+p)*j, h-(s+p)*2)
      (cr, s, s)
      local c = v == 1 and c1 or c2
      cr:set_source_rgba(gears.color.parse_color(c.."ff"))
      cr:fill()
    end

    for j, v in ipairs(Ms) do
      gears.shape.transform
      ( gears.shape.rectangle )
	: translate(w-(s+p)*j, h-(s+p))
      (cr, s, s)
      local c = v == 1 and c1 or c2
      cr:set_source_rgba(gears.color.parse_color(c.."ff"))
      cr:fill()
    end

    return img
  end
end
