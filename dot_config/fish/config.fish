source ~/.config/fish/aliases.fish
source ~/.config/fish/theme.fish

export EDITOR=spc

function sudo!!
  eval sudo $history[1]
end
