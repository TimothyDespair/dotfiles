local gruvbox =
  { bg = "#282828"
  , grey = "#928374"
  , red = "#cc241d"
  , brred = "#fb4934"
  , green = "#98971a"
  , brgreen = "#b8bb26"
  , yellow = "#d79921"
  , bryellow = "#fabd2f"
  , blue = "#458588"
  , brblue = "#83a598"
  , purple = "#b16286"
  , brpurple = "#d3869b"
  , cyan = "#689d6a"
  , brcyan = "#8ec07c"
  , brgrey = "#a89984"
  , fg = "#ebdbb2"
  , bg0_h = "#1d2021" }

local gv = gruvbox

local theme_dir = "themes/gruvy/"

local theme =
  { font = "Meslo LG S for Powerline 9"

  , wallpaper = require(theme_dir .. "wallpaper")(gv.brred, gv.bryellow, gv.brgreen, gv.bg0_h)

  , useless_gap = dpi(3)

  , volume =
    { char = "VOLUME"
    , font = "Meslo LG S for Powerline 9"}

  , color = gruvbox.fg
  , bg_color = gv.grey
  , bar =
    { bg_color = gv.bg
    , height = dpi(16) }
  , launcher_icon = require(theme_dir .. "icons/launcher")(gv.brred, gv.bryellow, gv.brgreen) }

return theme

