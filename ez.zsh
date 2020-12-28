# ez.zsh
# Easy ZSH base configuration to get you a fast, full featured, sane, and modern Z shell
#
# http://github.com/mattmc3/ez
# Copyright mattmc3, 2020-2021
# MIT license, https://opensource.org/licenses/MIT
### ZSH Options
#region

# http://zsh.sourceforge.net/Doc/Release/Options.html

# Changing Directories
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir
setopt auto_pushd              # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups       # don’t push multiple copies of the same directory onto the directory stack
setopt pushd_minus             # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

# Completions
# http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
setopt always_to_end           # move cursor to the end of a completed word
setopt auto_list               # automatically list choices on ambiguous completion
setopt auto_menu               # show completion menu on a successive tab press
setopt auto_param_slash        # if completed parameter is a directory, add a trailing slash
setopt complete_in_word        # complete from both ends of a word
setopt no_menu_complete        # don't autoselect the first completion entry

# Expansion and Globbing
# http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
setopt extended_glob           # use more awesome globbing features
setopt glob_dots               # include dotfiles when globbing

# History
# http://zsh.sourceforge.net/Doc/Release/Options.html#History

# Initialization
# http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation

# Input/Output
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
setopt no_clobber              # must use >| to truncate existing files
setopt no_correct              # don't try to correct the spelling of commands
setopt no_correct_all          # don't try to correct the spelling of all arguments in a line
setopt no_flow_control         # disable start/stop characters in shell editor
setopt interactive_comments    # enable comments in interactive shell
setopt no_mail_warning         # don't print a warning message if a mail file has been accessed
setopt path_dirs               # perform path search even on command names with slashes
setopt rc_quotes               # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
setopt no_rm_star_silent       # ask for confirmation for `rm *' or `rm path/*'

# Job Control
# http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
setopt auto_resume            # attempt to resume existing job before creating a new process
setopt no_bg_nice             # don't run all background jobs at a lower priority
setopt no_check_jobs          # don't report on jobs when shell exit
setopt no_hup                 # don't kill jobs on shell exit
setopt long_list_jobs         # list jobs in the long format by default
setopt notify                 # report status of background jobs immediately

# Prompting
# http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
setopt prompt_subst           # expand parameters in prompt variables

# Scripts and Functions
# http://zsh.sourceforge.net/Doc/Release/Options.html#Scripts-and-Functions

# Shell Emulation
# http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-Emulation

# Shell State
# http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-State

# Zle
# http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
setopt no_beep                # be quiet!
setopt combining_chars        # combine zero-length punctuation characters (accents) with the base character

#endregion

### Environment
#region

# XDG base dirs
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
  export XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
  export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
  export XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME/Music}"
  export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
  export XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-$HOME/Public}"
fi

# General environment variables that everyone needs
export CLICOLOR="1"
export LSCOLORS="${LSCOLORS:-ExfxcxdxbxGxDxabagacad}"

export PAGER="${PAGER:-less}"
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-$EDITOR}"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

#endregion

### History
#region

# http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt no_hist_beep            # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
setopt no_share_history        # don't share history between all sessions

# $HISTFILE does not belong with config files, it belongs in the data home
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
if [[ ! -f "$HISTFILE" ]]; then
  mkdir -p "$HISTFILE:h" && touch "$HISTFILE"
fi

# you can set $SAVEHIST and $HISTSIZE to anything greater than 1000 and 2000
# respectively, but if not we'll set the values to something bigger.
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=20000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000

#endregion

### .zshrc.d
#region

function source_config_dir() {
  # source ZSH config files from .zshrc.d
  local zshrcdir zfile
  if [[ -n "$1" ]]; then
    zshrcdir="$1"
  else
    zshrcdir="${ZDOTDIR:-$HOME}/.zshrc.d"
    # no need to hide it with a leading dot in $ZDOTDIR
    [[ -d "$ZDOTDIR/zshrc.d" ]] && zshrcdir="$ZDOTDIR/zshrc.d"
  fi
  if [[ ! -d "zshrcdir" ]]; then
    echo "zshrc.d dir not found: $zshrcdir" >&2 && return 1
  fi
  # source zshrc.d
  for zfile in "$zshrcdir"/*.{sh,zsh}(.N); do
    # ignore files that begin with a tilde
    case $zfile:t in ~*) continue;; esac
    source "$zfile"
  done
}

#endregion

### .zfunctions
#region

# lazy load zfunctions
_zfuncdir="${ZDOTDIR:-$HOME}/.zfunctions"
# no need to hide it with a leading dot in $ZDOTDIR
[[ -d "$ZDOTDIR"/zfunctions ]] && _zfuncdir="$ZDOTDIR"/zfunctions
if [[ -d "$_zfuncdir" ]]; then
  fpath=("$_zfuncdir" $fpath)
  for _zfunc in "$_zfuncdir"/*(.N); do
    autoload -Uz "$_zfunc"
  done
fi
unset _zfuncdir _zfunc

#endregion
