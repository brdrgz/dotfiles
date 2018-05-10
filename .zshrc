export PATH="/Users/blake/.gem/ruby/2.2.3/bin:/Users/blake/.rubies/ruby-2.2.3/lib/ruby/gems/2.2.0/bin:/Users/blake/.rubies/ruby-2.2.3/bin:/usr/local/sbin:/usr/local/Cellar/php53/5.3.29_4/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:/usr/local/CrossPack-AVR/bin"

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

chruby ruby-2.3.1

ky="ผมรักเบ็คกี้"

# Completion
autoload -Uz compinit
compinit

# History
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Emacs shortcuts
bindkey -e

# Prompt
autoload -Uz vcs_info
precmd () { vcs_info }

zstyle ':vcs_info:git:*' formats '⌥  %b'

setopt prompt_subst

autoload -U colors && colors

prompt () {
  PROMPT="%{$fg_bold[cyan]%}%n%{$reset_color%} %{$fg_bold[green]%}%M%{$reset_color%} %{$fg_bold[red]%}%~%{$reset_color%} ${vcs_info_msg_0_} %{$fg_bold[white]%}$%{$reset_color%} "
}

precmd_functions+=(prompt)
