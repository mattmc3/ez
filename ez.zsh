# ez.zsh
# EZ - Easy ZSH configuration to start you off with better Z shell defaults
#
# http://github.com/mattmc3/ez
# Copyright mattmc3, 2020-2021
# MIT license, https://opensource.org/licenses/MIT

### Environment
#region

# XDG base dirs
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"

#endregion

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

### Convenience functions
#region

function ez_source_confdir() {
  # source ZSH config files
  local configdir="$1"
  [[ -z "$configdir" ]] && echo "expecting config dir argument" >&2 && return 1
  [[ ! -d "$configdir" ]] && echo "config dir not found: $configdir" >&2 && return 1

  # source configdir
  local f
  local files=("$configdir"/*.{sh,zsh}(.N))
  for f in ${(o)files}; do
    # ignore files that begin with a tilde
    case $f:t in ~*) continue;; esac
    source "$f"
  done
}

function ez_autoload_funcdir() {
  ### lazy load functions dir
  local funcdir="$1"
  [[ -z "$funcdir" ]] && echo "expecting function dir argument" >&2 && return 1
  [[ ! -d "$funcdir" ]] && echo "function dir not found: $funcdir" >&2 && return 1

  fpath=("$funcdir" $fpath)
  local fn
  for fn in "$funcdir"/*(.N); do
    autoload -Uz "$fn"
  done
}

# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L44
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
# https://htr3n.github.io/2018/07/faster-zsh/
function ez_run_compinit() {
  # run compinit in a smarter, faster way
  setopt localoptions extendedglob
  ZSH_COMPDUMP=${ZSH_COMPDUMP:-$XDG_CACHE_HOME/zsh/zcompdump}
  autoload -Uz compinit
  # Glob magic explained:
  #   #q expands globs in conditional expressions
  #   N - sets null_glob option (no error on 0 results)
  #   mh-20 - modified less than 20 hours ago
  if [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$ZSH_COMPDUMP"
  else
    mkdir -p "$ZSH_COMPDUMP:h"
    compinit -i -d "$ZSH_COMPDUMP"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      zcompile "$ZSH_COMPDUMP"
    fi
  } &!
}

#endregion
