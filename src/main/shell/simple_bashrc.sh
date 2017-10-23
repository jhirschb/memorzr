#!/env bash

export HISTCONTROL=ignoreboth:erasedups

alias gitl="git log -n 10 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold     blue)<%an>%Creset%n' --abbrev-commit --date=relative --branches";

alias pserv="python -m SimpleHTTPServer 8000";
alias s="git status";
alias b="git branch";
alias re="git rebase";
alias fe="git fetch";


function title {
    echo -en "\033]0;$@\007";
}

###########################################
#
#                Prompt
#
###########################################
parse_git_branch() {
  if [[ $(git rev-parse --show-toplevel 2>/dev/null) = "$PWD" ]]; then
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/';
  fi
}
user_icon() {
  if [ $(whoami) = "root" ]; then echo '☠'; else echo -e '☀'; fi
}

function dynprompt {
  local USR="\[\e[44;30m\]\u@\h";
  local PTH="\[\e[0;37m\]\w";
  local GIT="\[\e[43;38m\]";
  local SPCR=$'\u21a0';
  local CUL=$'\u23a1';
  local CLL=$'\u23a3';
  local THDR=$'\u21af';
  local TIME="\[\e[44;34m\][\t]";
  local END="\[\e[0m\]";
  
export PS1="${CUL} $(user_icon) ${USR} $SPCR ${TIME} $SPCR ${PTH} ${GIT}\$(parse_git_branch)${END}\n"${CLL}" "${THDR}" "
}

dynprompt;


