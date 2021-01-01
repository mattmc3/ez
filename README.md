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

## Usage

If you want a nice starter .zshrc, you could start with something like this:

```shell
# grab EZ if we don't already have it
PLUGINS_DIR="${ZDOTDIR:-$HOME/.config/zsh}"/plugins
[[ -d $PLUGINS_DIR/ez ]] ||
  git clone --depth=1 https://github.com/mattmc3/ez.git $PLUGINS_DIR/ez

# source EZ to set better ZSH defaults
source $PLUGINS_DIR/ez/ez.zsh

# use oh-my-zsh or a plugin manager or your own custom config
# ... do stuff ...

# run our EZ functions if we want this added functionality
ez_autoload_funcdir "${ZDOTDIR:-$HOME/.config/zsh}"/zfunctions
ez_source_confdir "${ZDOTDIR:-$HOME/.config/zsh}"/zshrc.d
ez_run_compinit
```

## Installation

### Install with a plugin manager

Installing with a plugin manager is the recommended method so that you can get updates.

- [pz]: `pz source mattmc3/ez`
- [znap]: `znap source mattmc3/ez`
- [antibody]: `antibody bundle mattmc3/ez`
- [antigen]: `antigen bundle mattmc3/ez`
- [zgen]: `zgen load mattmc3/ez`

### Install manually

With git:

```shell
git clone --depth=1 https://github.com/mattmc3/ez.git "${ZDOTDIR:-$HOME/.config/zsh}"/plugins
```

-OR- with a single file download:

```shell
mkdir -p "${ZDOTDIR:-$HOME}"/plugins/ez
curl -fsSL https://raw.githubusercontent.com/mattmc3/ez/main/ez.zsh -o "${ZDOTDIR:-$HOME}"/plugins/ez/ez.zsh
```

Then source the file in your .zshrc:

```shell
. "${ZDOTDIR:-$HOME}"/plugins/ez/ez.zsh
```

### Insall with a framework

Using [oh-my-zsh][ohmyzsh]:

1. Add the EZ plugin to your OMZ custom path

    ```shell
    git clone https://github.com/mattmc3/ez ${ZSH_CUSTOM:-$ZSH/custom}/plugins/ez
    ```

1. Add EZ to your `plugins` list in your OMZ.

    ```shell
    plugins=(
        ...
        ez
    )
    ```

[antigen]: https://github.com/zsh-users/antigen
[antibody]: https://getantibody.github.io
[ohmyzsh]: https://github.com/ohmyzsh/ohmyzsh
[pz]: https://github.com/mattmc3/pz
[znap]: https://github.com/marlonrichert/zsh-snap
[zgen]: https://github.com/tarjoilija/zgen
[zsh-options]: http://zsh.sourceforge.net/Doc/Release/Options.html
[zsh-history]: http://zsh.sourceforge.net/Guide/zshguide02.html
[xdg-basedirs]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
