local awful = require("awful")

local settings = {}

settings.terminal = "urxvt"
settings.editor = os.getenv("EDITOR") or "vim"
settings.editor_cmd = settings.terminal .. " -e " .. settings.editor
settings.modkey = "Mod4"

settings.themes =
  { "default" }
settings.active_theme = "default"

settings.bar_themes =
  { "laptop" }
settings.active_bar_theme = "laptop"

settings.layouts =
  { awful.layout.suit.floating
  , awful.layout.suit.tile
  -- , awful.layout.suit.tile.left
  , awful.layout.suit.tile.bottom
  -- , awful.layout.suit.tile.top
  , awful.layout.suit.fair
  , awful.layout.suit.fair.horizontal
  -- , awful.layout.suit.spiral
  -- , awful.layout.suit.spiral.dwindle
  , awful.layout.suit.max
  -- , awful.layout.suit.max.fullscreen
  -- , awful.layout.suit.magnifier
  -- , awful.layout.suit.corner.nw
  -- , awful.layout.suit.corner.ne
  -- , awful.layout.suit.corner.sw
  --[[, awful.layout.suit.corner.se]] }

return settings
