export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

export MANPATH="/opt/local/share/man:$MANPATH"

if [[ -d "$HOME/bin" ]] ; then
    PATH="$HOME/bin:$PATH"
fi
