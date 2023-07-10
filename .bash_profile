#
# ~/.bash_profile
#

# Start X server after successfull login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
startx
fi

# Run bashrc if exists in home directory
[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
