local naughty = require("naughty")

return function (err)
  naughty.notify
  ( { preset = naughty.config.presets.critical
    , title = "Something went wrong:"
    , text = err } )
end
