export ZSH="$HOME/.oh-my-zsh"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="crcandy"
#wanna try agnoster spaceship and other themes
#ZSH_THEME="jonathen"
#ZSH_THEME="bira"
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"

#eval "$(starship init zsh)"

plugins=(git extract sudo) #can add node npm yarn etc

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/npmpath
source ~/.config/aliases
source ~/.config/custom_zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/akio/hdd/Anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/akio/hdd/Anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/akio/hdd/Anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/akio/hdd/Anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


