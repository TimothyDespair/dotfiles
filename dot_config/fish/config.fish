source ~/.config/fish/aliases.fish
source ~/.config/fish/theme.fish

export EDITOR="emacs -nw"

function sudo!!
  eval sudo $history[1]
end
