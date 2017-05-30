function setup_ps1 {
    # Colors
    local txtblk='\[\e[0;30m\]' # Black - Regular
    local txtred='\[\e[0;31m\]' # Red
    local txtgrn='\[\e[0;32m\]' # Green
    local txtylw='\[\e[0;33m\]' # Yellow
    local txtblu='\[\e[0;34m\]' # Blue
    local txtpur='\[\e[0;35m\]' # Purple
    local txtcyn='\[\e[0;36m\]' # Cyan
    local txtwht='\[\e[0;37m\]' # White
    local bldblk='\[\e[1;30m\]' # Black - Bold
    local bldred='\[\e[1;31m\]' # Red
    local bldgrn='\[\e[1;32m\]' # Green
    local bldylw='\[\e[1;33m\]' # Yellow
    local bldblu='\[\e[1;34m\]' # Blue
    local bldpur='\[\e[1;35m\]' # Purple
    local bldcyn='\[\e[1;36m\]' # Cyan
    local bldwht='\[\e[1;37m\]' # White
    local undblk='\[\e[4;30m\]' # Black - Underline
    local undred='\[\e[4;31m\]' # Red
    local undgrn='\[\e[4;32m\]' # Green
    local undylw='\[\e[4;33m\]' # Yellow
    local undblu='\[\e[4;34m\]' # Blue
    local undpur='\[\e[4;35m\]' # Purple
    local undcyn='\[\e[4;36m\]' # Cyan
    local bakgrn='\[\e[42m\]' # Green
    local bakylw='\[\e[43m\]' # Yellow
    local bakblu='\[\e[44m\]' # Blue
    local bakpur='\[\e[45m\]' # Purple
    local bakcyn='\[\e[46m\]' # Cyan
    local bakwht='\[\e[47m\]' # White
    local hiblk='\[\e[0;90m\]' # Black - High intensity
    local hired='\[\e[0;91m\]' # Red
    local higrn='\[\e[0;92m\]' # Green
    local hiylw='\[\e[0;93m\]' # Yellow
    local hiblu='\[\e[0;94m\]' # Blue
    local hipur='\[\e[0;95m\]' # Purple
    local hicyn='\[\e[0;96m\]' # Cyan
    local hiwht='\[\e[0;97m\]' # White
    local coolblk='\[\e[38;5;244m\]'
    local coolpur='\[\e[38;5;98m\]'
    local coolora='\[\e[38;5;215m\]'
    local coolpur2='\[\e[38;5;63m\]'
    local clroff='\[\e[0m\]' # Text Reset

    local time24h="\A"
    local path="\w"
    local newline="\n"
    local user="\u"
    local host="\h"

    function parse_login_shell {
	shopt -q login_shell && echo '(login) '
    }
    function parse_status {
	if [[ $? != 0 ]]; then
	    echo "$bldred(x)$clroff"
	fi
    }

    function format_git_branch {
	local branch="$(git branch --no-color 2> /dev/null | \
 sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"

	if [ -n "$branch" ]; then
	    printf "⍭[$branch]"
	fi
    }
    local name='lia bifano'
    local curtime="$coolblk$time24h$clroff"
    local user_at_host="♡  $coolpur2$name$clroff"
    local status="$hired \$(parse_status)"
    local path="$coolblk ($path)"
    local git_branch="$txtgrn \$(format_git_branch)"
    local login_shell_indicator="$coolblk $(parse_login_shell)"
    local final="$coolora ➝  "

    PS1=""
    PS1+=$curtime
    PS1+=$status
    PS1+=$user_at_host
    PS1+=$path
    PS1+=$git_branch
    PS1+=$newline
    PS1+=$final

    PS1+=$clroff
}
setup_ps1

# configs
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYSPARK_SUBMIT_ARGS="--master local[2]"

# aliases
source "$HOME/.my_aliases.sh"

# keys
source "$HOME/.my_secrets.sh"

# paths
source "$HOME/.my_secrets_paths.sh"
export PATH="/Users/lexa/anaconda/bin:$PATH"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# docker-machine
docker-machine start default
eval "$(docker-machine env default)"
