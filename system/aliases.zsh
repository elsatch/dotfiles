export CLICOLOR=1


alias xcode='open -a xcode'
alias pre='open -a Preview'
alias l='ls -al'
alias u='cd ..'
alias uu='cd ..; cd ..'
alias uuu='cd ..; cd ..; cd ..'
alias ttop='top -U $USER'
alias lsd3='du -sk * | sort -nr | head -3'
alias mvim='mvim --remote-tab-silent'
alias wgetssl='wget --no-check-certificate'


function ta()
{
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

function flushdns()
{
    dscacheutil -flushcache
    sudo kill -HUP `cat /opt/local/var/run/dnsmasq.pid`
    # sudo port unload dnsmasq
    # sudo port load dnsmasq
}

function gih () { identify -format "%h" "$@" | tr -d '\n' | pbcopy; }
function giw () { identify -format "%w" "$@" | tr -d '\n' | pbcopy; }
function mkcd () { mkdir -p "$@" && cd "$@"; }

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
alias mysql_start='sudo /opt/local/bin/mysqld_safe5 &'
alias mysql_stop='sudo /opt/local/bin/mysqladmin5 -u -root shutdown'
alias mysql_restart='mysql_stop; mysql_start'

# apache
alias restart_apache='sudo /opt/local/apache2/bin/apachectl restart'

alias lh='ls -algH --color=always | egrep --color=never "\..*$"'
alias cwd="pwd | tr -d '\n' | pbcopy"
alias lh='ls -ald .*'
alias grep='grep --color=auto --exclude=\.svn'
alias secureemptytrash='srm -rs /Users/kenny/.Trash/*'
alias rmdotsvn='find . -name ".svn" -type d -exec rm -rf {} \;'
alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox-bin -profilemanager'

#function mirror_page_old() { wget --ignore-length --mirror --page-requisites --convert-links --no-verbose --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0) Gecko/20100101 Firefox/6.0" --directory-prefix=./ $1 }

# function mirror_page() { wget --adjust-extension --page-requisites --span-hosts --backup-converted --ignore-length --convert-links --no-verbose --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0) Gecko/20100101 Firefox/6.0" --directory-prefix=./ $1 }
 
alias linecount="sed '/^\s*$/d' | wc -l"

function expandurl() { curl -sIL $1 | grep ^Location; }

function mygrants()
{
  mysql -B -N $@ -e "SELECT DISTINCT CONCAT('SHOW GRANTS FOR ''', user, '''@''', host, ''';') AS query FROM mysql.user" | mysql $@ | sed 's/\(GRANT .*\)/\1;/;s/^\(Grants for .*\)/## \1 ##/;/##/{x;p;x;}'
}

# brought here from dotfiles/zsh/aliases.zsh before it was deleted
alias dotf='cd $ZSH'
alias findps='ps aux | grep -v grep | grep'
alias reload!='. ~/.zshrc'


function cdf ()
{
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

