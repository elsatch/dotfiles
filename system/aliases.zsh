export CLICOLOR=1

# temp alias: macports update to all ports except pcre (pcre 8.30 breaks WP)
alias macports_upgrade_cmd="sudo port upgrade `port list outdated | awk '{print $1}' | grep -v pcre | tr '\n' ' '`"

# open in...
alias pre='open -a Preview'
alias mvim='mvim --remote-tab-silent'
alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox-bin -profilemanager'

# list files
alias l='ls -al'
alias lh='ls -ald .*'
alias lsd3='du -sk * | sort -nr | head -3'

# change dir (or make and change)
alias u='cd ..'
alias uu='cd ..; cd ..'
alias uuu='cd ..; cd ..; cd ..'
function mkcd () { mkdir -p "$@" && cd "$@"; }

# other misc
alias ttop='top -U $USER'
alias cwd="pwd | tr -d '\n' | pbcopy"
alias wgetssl='wget --no-check-certificate'
alias gst='git status'
alias grep='grep --color=auto --exclude=\.svn'
alias secureemptytrash='srm -rs /Users/kenny/.Trash/*'
alias rmdotsvn='find . -name ".svn" -type d -exec rm -rf {} \;'
alias linecount="sed '/^\s*$/d' | wc -l"

# where does a 301 point to
function expandurl() { wget -q -U Mozilla/5 -O/dev/null -S $@ 2>&1 | awk '{ if($1~/^Location:/) { print $2 } }'; }

# this is how I start and reattach tmux
function ta() {
    # use this to find out what to set TMPDIR to if ta() wasn't used:
    # `echo /var/folders/**/*/-Tmp-(U/)`
    # then attache with `TMPDIR=$$ tmux attach`

    unset TMPDIR
    if [[ `tmux list-sessions 2>&1 | grep "^failed to connect to server" -c` -eq 0 ]];
    then
        tmux attach 
    else
        tmux new-session
    fi
}

# flush osx dns (including dnsmasq)
function flushdns() {
    dscacheutil -flushcache
    sudo kill -HUP `cat /opt/local/var/run/dnsmasq.pid`
    # sudo port unload dnsmasq
    # sudo port load dnsmasq
}

# get image height/width and copy to clipboard
function gih () { identify -format "%h" "$@" | tr -d '\n' | pbcopy; }
function giw () { identify -format "%w" "$@" | tr -d '\n' | pbcopy; }

# try to extract any archive
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# nginx
alias nginx_start='sudo nginx'
alias nginx_stop='sudo kill `cat /opt/local/var/run/nginx/nginx.pid`'
alias nginx_test_config='sudo nginx -t'
alias nginx_reload='sudo nginx -s reload'

# php-fpm53
alias fpm53_stop='sudo kill `cat /opt/local/var/run/php53/php-fpm.pid`'
alias fpm53_start='sudo php-fpm53'
alias fpm53_restart='fpm53_stop; fpm53_start'

# php-fpm54
alias fpm54_stop='sudo kill `cat /opt/local/var/run/php54/php-fpm.pid`'
alias fpm54_start='sudo php-fpm54'
alias fpm54_restart='fpm54_stop; fpm54_start'

# mysql
alias mysql_start='sudo /opt/local/share/mysql5/mysql/mysql.server start'
alias mysql_stop='sudo /opt/local/share/mysql5/mysql/mysql.server stop'
alias mysql_restart='mysql_stop; mysql_start'

# apache
alias restart_apache='sudo /opt/local/apache2/bin/apachectl restart'

# # wget mirrors a page for local archiving
# function mirror_page() { 
#     wget --adjust-extension --page-requisites --span-hosts --backup-converted --ignore-length --convert-links --no-verbose --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0) Gecko/20100101 Firefox/6.0" --directory-prefix=./ $1 
# }
 
# show my grants in mysql
function mygrants() {
  mysql -B -N $@ -e "SELECT DISTINCT CONCAT('SHOW GRANTS FOR ''', user, '''@''', host, ''';') AS query FROM mysql.user" | mysql $@ | sed 's/\(GRANT .*\)/\1;/;s/^\(Grants for .*\)/## \1 ##/;/##/{x;p;x;}'
}

# snag an mp3 from youtube and title it properly
function ytmp3() {
    youtube-dl -kvt --extract-audio --audio-quality 160k --audio-format mp3 $1
}

# Remove the hosts that I don't want to keep around - in this case, only keep the first host.
alias hosts="head -2 ~/.ssh/known_hosts | tail -1 > ~/.ssh/known_hosts"

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# helper function to build multiline regex with '+' line continuation character (as/400 CL)
function mlregex() {
    if [[ "$#" != "1" ]]; then
        return
    fi

    x="$1"
    len=${#x}
    final=''
    # joiner='\\\\+\\\\s*\\\\n?^\\\\s*'
    joiner='\\+\\s*\\n?^\\s*'

    for ((i = 1; i < $len; i++));
    do
        if [[ $i -ne 1 ]]; then
            final="$final|"
        fi
        final="${final}${x:0:$i}${joiner}${x:$i:$len}"
    done

    echo -n "$final|$x"

    # return $final
}

# base64 a file and copy to clipboard
function base64 () { openssl base64 < "$1" | tr -d '\n' | pbcopy }

# change directory to whatever the most recently focused finder window is
function cdf () {
  CURRFOLDERPATH=$( /usr/bin/osascript <<"    EOT"
    tell application "Finder"
      try
          set currFolder to (folder of the front window as alias)
      on error
          set currFolder to (path to desktop folder as alias)
      end try
      POSIX path of currFolder
    end tell
    EOT
  )
  echo "cd to \"$CURRFOLDERPATH\""
  cd "$CURRFOLDERPATH"
}
