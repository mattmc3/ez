# ez

EZ - Easy ZSH configuration to start you off with better Z shell defaults

## Details

EZ gives you:

- Much better starting ZSH options. See [ZSH options][zsh-options].
- Much better history setup. [See ZSH startup file guidance][zsh-history].
- Environment variables to help you have a less cluttered home directory. See [XDG Base directory specs][xdg-basedirs].
- Helpful convenience functions

## Functions

| Function            | Args        | Description                                             |
|:--------------------|:------------|:--------------------------------------------------------|
| ez_autoload_funcdir | \<funcdir\> | create autoload functions from the files in a directory |
| ez_run_compinit     |             | run compinit in a smarter, faster way                   |
| ez_source_confdir   | \<confdir\> | source all *.zsh/*.sh files in a directory              |

## .zshrc

If you want a nice starter .zshrc, you might to something like this:

```shell
# setup pz as our plugin manager
PZ_PLUGINS_DIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"
[[ -d $PZ_PLUGINS_DIR/pz ]] ||
  git clone --depth=1 https://github.com/mattmc3/pz.git $PZ_PLUGINS_DIR/pz
source $PZ_PLUGINS_DIR/pz/pz.zsh

# setup a nice prompt
pz prompt sindresorhus/pure

# install EZ and some plugins
pz source mattmc3/ez
pz source zsh-users/zsh-autosuggestions
pz source zsh-users/zsh-completions
pz source zsh-users/zsh-history-substring-search

# run our EZ functions
ez_autoload_funcdir $ZDOTDIR/zfunctions
ez_source_confdir $ZDOTDIR/zshrc.d
ez_run_compinit

# add syntax highlighting at the very end
pz source zdharma/fast-syntax-highlighting
```

## Installation

- [pz]: `pz source mattmc3/ez`
- [znap]: `znap source mattmc3/ez`
- [antibody]: `antibody bundle mattmc3/ez`
- [antigen]: `antigen bundle mattmc3/ez`
- [zgen]: `zgen load mattmc3/ez`
- [ohmyzsh]: `git clone https://github.com/mattmc3/ez ${ZSH_CUSTOM:-$ZSH/custom}/plugins/pz`

[antigen]: https://github.com/zsh-users/antigen
[antibody]: https://getantibody.github.io
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[pz]: https://github.com/mattmc3/pz
[znap]: https://github.com/marlonrichert/zsh-snap
[zgen]: https://github.com/tarjoilija/zgen
[zsh-options]: http://zsh.sourceforge.net/Doc/Release/Options.html
[zsh-history]: http://zsh.sourceforge.net/Guide/zshguide02.html
[xdg-basedirs]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
