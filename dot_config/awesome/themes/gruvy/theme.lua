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

  , fg_normal = gv.fg
  , bg_normal = gv.bg
  , bar =
    { bg_color = gv.bg
    , height = dpi(16) }
  , launcher_icon = require(theme_dir .. "icons/launcher")(gv.brred, gv.bryellow, gv.brgreen) }

local cairo = require("lgi").cairo
local gears = require("gears")

local title_button = require(theme_dir .. "icons/title_button")

theme.titlebar_bg_focus = gv.bg
theme.titlebar_bg_normal = gv.bg

theme.titlebar_close_button_normal = require(theme_dir .. "icons/close_button")(gv.brgrey)
theme.titlebar_close_button_focus = require(theme_dir .. "icons/close_button")(gv.red)

theme.titlebar_maximized_button_normal_inactive = title_button(gv.grey)
theme.titlebar_maximized_button_focus_inactive = title_button(gv.yellow)
theme.titlebar_maximized_button_normal_active = title_button(gv.grey)
theme.titlebar_maximized_button_focus_active = title_button(gv.yellow)

theme.titlebar_minimize_button_normal = title_button(gv.brgrey)
theme.titlebar_minimize_button_focus = title_button(gv.green)

theme.titlebar_floating_button_normal_inactive = require(theme_dir .. "icons/first_button")(gv.grey)
theme.titlebar_floating_button_focus_inactive = require(theme_dir .. "icons/first_button")(gv.blue)
theme.titlebar_floating_button_normal_active = require(theme_dir .. "icons/first_button")(gv.grey)
theme.titlebar_floating_button_focus_active = require(theme_dir .. "icons/first_button")(gv.blue)

theme.titlebar_sticky_button_normal_inactive = title_button(gv.brgrey)
theme.titlebar_sticky_button_focus_inactive = title_button(gv.purple)
theme.titlebar_sticky_button_normal_active = title_button(gv.brgrey)
theme.titlebar_sticky_button_focus_active = title_button(gv.purple)

theme.titlebar_ontop_button_normal_inactive = title_button(gv.grey)
theme.titlebar_ontop_button_focus_inactive = title_button(gv.cyan)
theme.titlebar_ontop_button_normal_active = title_button(gv.grey)
theme.titlebar_ontop_button_focus_active = title_button(gv.cyan)

return theme

