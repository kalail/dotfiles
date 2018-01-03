# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Start SSH agent on first login.
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Colors
COLOR_NEUTRAL="\[\e[48;5;237m\]"
COLOR_RESET="\[\e[0m\]"
COLOR_1="\[\e[48;5;196m\]"
COLOR_2="\[\e[48;5;202m\]"
COLOR_3="\[\e[48;5;197m\]"
COLOR_4="\[\e[48;5;233m\]"

# Fancy prompt.
prompt_cmd () {
    # Prompt format.
    # TIME://USERNAME@HOSTNAME/PATH?KEY=VALUE

    # PS1="\n"
    PSL="${COLOR_1} \u ${COLOR_RESET}"
    PSL+="${COLOR_2} \h ${COLOR_RESET}"
    PSL+="${COLOR_3} \w ${COLOR_RESET}"

    PSR="${COLOR_3} - ${COLOR_RESET}"
    PSR+="${COLOR_2} master ${COLOR_RESET}"
    PSR+="${COLOR_1} $$ ${COLOR_RESET}"

    # PS1+="${txtrst}?"
    # PS1+="${txtcyn}datetime"
    # PS1+="${txtrst}="
    # PS1+="${txtpur}\D{%Y-%m-%dT%H:%M:%S}"

    # if ! [[ -z "$VIRTUAL_ENV" ]]; then
    #     PSL+="${txtrst}&"
    #     PSL+="${txtcyn}venv"
    #     PSL+="${txtrst}="
    #     PSL+="${txtpur}$VIRTUAL_ENV"
    # fi

    # if [ "$(type -t deactivate)" = 'function' ]; then
    #     deactivate
    # fi

    # if [ -d "venv" ]; then
    #     VIRTUAL_ENV_DISABLE_PROMPT=1
    #     source venv/bin/activate
    # fi
    # local branch
    # if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    #     local status=$(git status --porcelain 2> /dev/null)
    #     if [[ "$status" != "" ]]; then
    #         git_dirty='*'
    #     else
    #         git_dirty=''
    #     fi
    #     PSL+="${txtrst}&"
    #     PSL+="${txtcyn}git"
    #     PSL+="${txtrst}="
    #     PSL+="${txtpur}$branch$git_dirty"
    # fi

    # Prompt.
    # PSL+="${COLOR_RESET}\n"
    # "${PS1}"
    # PSL+="${COLOR_4}▶${COLOR_RESET} "

    PS1="${PSL} ▶ "

    # PS1=$(printf "%*s\r%s ▶ " "$(($(tput cols) - $(printf "%s" "$PSR" | wc -c)))" "${PSR}" "${PSL}")

}
export PROMPT_COMMAND='prompt_cmd'

export TERM=xterm-256color
export EDITOR=nvim

export PATH="$HOME/.cargo/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# FZF completions.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Bash completions.
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export PATH=~/.local/bin:$PATH  # Not sure why pip is putting things in here.
export PATH="/usr/local/opt/node@6/bin:$PATH"
