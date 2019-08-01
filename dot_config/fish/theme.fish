set fish_color_normal white
set fish_color_command brcyan --bold
set fish_color_quote white
set fish_color_redirection bryellow --bold
set fish_color_end bryellow --bold
set fish_color_error brred --bold
set fish_color_param white
set fish_color_comment grey --bold
set fish_color_match brgreen --bold
set fish_color_selection --background=green
set fish_color_search_match --background=green
set fish_color_operator bryellow
set fish_color_escape brblue --bold
set fish_color_cwd brblue --bold
set fish_color_autosuggestion grey
set fish_color_user bryellow --bold
set fish_color_host brgreen --bold
set fish_color_cancel brred --bold

set fish_pager_color_prefix brgreen --bold
set fish_pager_color_completion bryellow
set fish_pager_color_description grey
set fish_pager_color_progress blue

function fish_prompt -d "Write out the prompt"
  printf '%s%s%s@%s%s%s:%s%s%s>%s ' \
    (set_color $fish_color_user) (whoami) (set_color cyan --bold) (set_color normal) \
    (set_color $fish_color_host) (hostname | cut -d . -f 1) \
    (set_color $fish_color_cwd) (prompt_pwd) \
    (set_color bryellow --bold) (set_color normal --regular)
end
