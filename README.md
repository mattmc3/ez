# ez

EZ - Easy ZSH configuration to start you off with better Z shell defaults

## Details

EZ gives you:

- Much better starting ZSH options. See [ZSH options][zsh-options].
- Much better history setup. [See ZSH startup file guidance][zsh-history].
- Environment variables to help you have a less cluttered home directory. See [XDG Base directory specs][xdg-basedirs].
- Helpful convenience functions

## Functions

| Function         | Args        | Description                                             |
|:-----------------|:------------|:--------------------------------------------------------|
| autoload_funcdir | \<funcdir\> | create autoload functions from the files in a directory |
| run_compinit     |             | run compinit in a smarter, faster way                   |
| source_confdir   | \<confdir\> | source all *.zsh/*.sh files in a directory              |

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
