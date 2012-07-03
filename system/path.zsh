export PATH="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:/opt/local/bin:/opt/local/sbin:$PATH"

export MANPATH="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/share/man:/opt/local/share/man:$MANPATH"

if [[ -d "$HOME/bin" ]] ; then
    PATH="$HOME/bin:$PATH"
fi
