# Editor
alias spc="emacsclient -ct"
alias src="spc ~/.spacemacs"
# Awesome
export AWSMDIR="~/.config/awesome/"
alias arc="spc $AWSMDIR/rc.lua"
alias ath="spc $AWSMDIR/themes/default/theme.lua"
# Fish Shell
export FISHDIR="~/.config/fish/"
alias fal="spc $FISHDIR/aliases.fish; source $FISHDIR/aliases.fish"
alias frc="spc $FISHDIR/config.fish; source $FISHDIR/config.fish"
alias fth="spc $FISHDIR/theme.fish; source $FISHDIR/theme.fish"
# X Files
alias xrs="spc ~/.Xresources; xrdb -merge ~/.Xresources"
alias xdf="spc ~/.Xdefaults"
alias xrm="xrdb -merge ~/.Xresources"

