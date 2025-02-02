# .bashrc

# Miscellaneous

alias lsl='ls -l'
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

echo -e "\n$(/home/diogo/.local/bin/welcome)\n"

# Shorten prompt
PROMPT_DIRTRIM=2

# git gpg stuff
export GPG_TTY=$(tty)

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
