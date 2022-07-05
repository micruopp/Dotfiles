#!/opt/homebrew/bin/zsh

##
# .zshrc
#
# Main config file for zshell.
#/

source "$DOTFILES/sh/aliases"









# Apparently this line will only run on startup...
# And I'm assuming just on Linux.
# [[ $(fgconsole 2>/dev/null) == 1 exec startx && /home/username/some-script.sh ]]

##
# See 'Understanding the loop' for more 
#   insight on the REPL.
# Note: There is a difference between printing a new line in precmd and
#   adding a new line to the beginning of the prompt. 
#   A new line in the prompt maintains a blank line when the terminal is 
#   cleared.
#   Lines printed during precmd do not persist.
#/

##
# TODO: /zsh does not use these variables / add the prompt variables PS0 > PS4 into this timeline.
# Understanding the loop
# Quoting a deleted reddit account:
# >
# > (precmd)
# >     v
# > draw_prompt
# >     v
# > wait_for_input && input_command
# >     v
# > (preexec)
# >     v
# > command_execution
# >     v
# > (precmd)
# >     v
# > ...
#/

precmd() {}

# Simplify the prompt
#   "$(tput blink)" to blink; "$(tput sgr0)" to default
PROMPT=$'\n    %F{69}%n@%B%m\n    %~\n    >%b%f%F{159} '

preexec() {
  # Add a new line before the output
  print ""
  # echo -n "\\e[0;37m"
}

# Add some colors to the terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad


# --- traversal.zsh --- #
# Some things to help get around.
#
# Some convenience aliases
# TODO: Refactor the clear and list funtionality.
# TODO: Have this also take flags like -a and -la
alias ~='cd ~ && clear && ls -a'
alias /='cd / && clear && ls -a'

alias ..='cd .. && ls -a'
alias ...='cd ../.. && ls -a'
alias ....='cd ../../.. && ls -a'
alias .....='cd ../../../.. && ls -a'
alias ......='cd ../../../../.. && ls -a'

alias l='ls -a'
alias la='ls -la'

alias cl='clear'

# Change directory and list it
# TODO:  Make use of the above TODO once implemented.
cs() {
  cd $1 && ls
}

c() {
  clear
  cd $1
  ls -la
}


alias up="uptime | egrep -o 'up.*[0-9]:[0-9][0-9]'"

# --- idk.zsh --- #
#
# I don't know... a simple tool for managing 
#   shell scripts.
#/

## TODO: Expand idk to include all dotfiles
#
zsh_root_dir=$HOME'/Developer/lib/zsh/'

# Reserved words -- scripts in the root dir cannot be named these:
# create
# help

idk() {
#  filename=$1
#  if [[ "$#" == 0 ]] then;
#    _idk_open_and_source_script "/Users/michalruopp/.zshrc"
#  elif [[ "$#" == 1 ]] then;
#    message="Trying to open a script named "$filename" in th zsh root folder: "$zsh_root_dir""
#    echo $message
#    echo "Open and source $zsh_root_dir$filename."
    # check if arg is a reserved word
    #   call reserve word helper 
    # else check if files exists
    #   _idk_open_and_source_script
    # else 
    #   call flag getopts helper fn
#  else
#    echo 'More than two arguments.'
#    echo 'How to handle these cases is not determined yet.'
#  fi

__idk $@
}

# Open target with vim and source it after
# TODO: Add basic checks.
_idk_open_and_source_script() {
  vim "$1" && source "$1"
}

_idk_eval_reserved_word() {

}

_idk_eval_args() {

}

array=(foo bar baz foo)
pattern=f*
value=foo

#if (($array[(I)$pattern])); then
#  echo array contains at least one value that matches the pattern
#fi
#
#if (($array[(Ie)$value])); then
#  echo value is amongst the values of the array
#fi


# Command for editing this file, as well as other
# zshell scripts.
# TODO: Make this take arguments to open the files in ~/Developer/zsh/
__idk() {
  open_file=true
  while getopts ":chl" option; do
    case $option in
      c) # Create new file
         # Maybe it should just do this by default...
         # ...or does requiring the command prevent accidental additions?
         # ...yeah, otherwise I'd have to delete every typo.
         echo "idk TODO: create a new file in the library and open it for editing."
         open_file=false
         ;;
      h) # Display help options
         echo "idk go fuck yourself"
         open_file=false
         ;;
      l) # List the scripts in the library
         ls $HOME/Developer/lib/zsh/
         open_file=false
         ;;
      *) # Default
         echo "Bad flag"
         return 0
         ;;
    esac
  done

  if [[ ! "$open_file" == true ]] then;
    return 0
  fi

  scriptname=$1
  if [[ $scriptname ]] then;
    pathname="$HOME/Developer/lib/zsh/${scriptname}.zsh"
    if [[ -f "$pathname" ]] then;
      # TODO: The text editor probably shouldn't be hardcoded. Maybe there's
      #       an environment variable? 
      nvim "$pathname" && source "$pathname"
    else
      echo -e '\033[3m'"${scriptname}.zsh"'\033[23m'" is not in the library."
    fi
  else
    configfile="$HOME/Developer/Dotfiles/zshrc"
    vim $configfile && source $configfile
  fi
}


# --- worm.zsh --- #
# 
# SSH aliases and helpers.

# Not sure why I need this...
# fn worm can be something cooler...
# 
# The following command is used to transfer files across
# machines similarly to FTP, but instead over the SSH
# protocol:
#
#     scp $HOME/Downloads/Chunky-1.2.86.jar <user@host>:$HOME/Developer/paper-server
# 
# Integrating this into worm could be cool, and would make it worthwhile.
# I think keeping the aliases around anyways is smart.
worm() {
  host="$1"

  case $host in
    '')
      echo "worming into MacBookPro15,2..."
      ;;
    'mbp152'|'mbp15'|'152p'|'15p')
      echo "\n    Worming into MacBookPro152.local . . . \n"
      # ssh michalruopp@MacBookPro152.local
      # TODO: allow this computer to be accessed across the internet.
      ;;
    *)
      echo "\n     .  .   .    . \n"
      ;;
  esac
}


# --- applications.zsh --- #
#
# Includes shortcuts to applications,
# ...

code() {
  open -a "Visual Studio Code" $@
  # open -a "VSCodium" $@
}

vsc() {
  code $@
}

browse() {
  open -a "Firefox Developer Edition" ${@}index.html
  # open -a "Firefox" $@
  # open -a "Safari" $@
  # open -a "Orion" $@
}


search() {
  echo "TODO: implement a 'grep -A1 $1 ~/Developer/Notes/.session-*.txt' search"
  echo "TODO: create an interface to select a result"
  echo "TODO: implement lucky search, automatically opening first result in browser"
  echo "TODO: adding a bookmark to session should be automatic -- i shouldn't have to create a new file for each day"
}


# --- git --- #
# 
# aliases and helpers

#alias gits='git status'
#alias gitl='git log --oneline'
#alias gitc='git commit -am "'
     # This will open a prompt to
     # write the commit message.


# --- REMAINDER OF .zshrc --- #

# Print the current time and date
now() {
  echo -e '    \033[1m'$(date +%r)'\033[0m'
  echo -e '    \033[1m'$(date +%d.%m.%Y)'\033[0m'
}

# idk what this should do yet...
# I just know this should do something
# It should just run now() but with a cooler output.
wow() {
  echo -e '    \033[3;33mLike right now'
  echo ''
  echo -e '        \033[1;3;33m'$(date +%r)' on '$(date +%Y-%m-%d)'\033[0m'
  echo ''
  echo -e '    \033[3;33mLike wow'
}

itemizepath() {
  echo $PATH | sed 's/:/\n/g' | sort | uniq -c
}

# NVM settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Imports
zshpath=$HOME'/Developer/lib/zsh/'
extension='.zsh'
scriptnames=(
  "applications"
  "digitalocean"
  "git"
  "idk"
  "traversal"
  "worm"
)

# for script in "${scriptnames[@]}"
# do
  # source "${zshpath}${script}${extension}"
# done

#source "$zshpath"applications.zsh
#source "$zshpath"digitalocean.zsh
#source "$zshpath"git.zsh
#source "$zshpath"idk.zsh
#source "$zshpath"traversal.zsh
#source "$zshpath"worm.zsh

# Print source confirmation.
time=$(date +"%H:%M:%S")
echo -e "\033[3m.zshrc\033[0m sourced @ ${time}."

# Add path variables
# Ruby
path=('/opt/homebrew/opt/ruby/bin' $path)
path=('/opt/homebrew/lib/ruby/gems/3.1.0/bin' $path)
export PATH
