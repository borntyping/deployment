# set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color purple
set -g __fish_git_prompt_color_dirtystate green
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate normal
set -g __fish_git_prompt_color_untrackedfiles red
set -g __fish_git_prompt_color_upstream green
set -g __fish_git_prompt_color_downstream red

set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix " "

set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_char_dirtystate "+"
set -g __fish_git_prompt_char_untrackedfiles "+"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_char_cleanstate ""

function fish_prompt --description 'Write out the prompt'
  set_color purple
  echo -n "~> "
  echo -n "$USER"
  echo -n "@"
  echo -n (prompt_hostname)
  set_color brblue
  echo -n " "
  echo -n "$PWD"

  __fish_git_prompt " %s"

  set_color purple
  echo
  echo -n "~> "
  set_color normal
end

function gs
  git status
end
