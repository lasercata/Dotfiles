# Git
[git](https://git-scm.com) is a version control software.

## Configuration location
The configuration file is located at `~/.gitconfig`.

## Files
- `~/.gitconfig`: the configuration for `git` command line.

- `~/.git-github.conf`: my personal git configuration (name, email, sign key id) to use with GitHub (default)
- `~/.git-codeberg.conf`: my personal git configuration (name, email, sign key id) to use with Codeberg. Used only when in a given folder (see [`.gitconfig`](.gitconfig)).

## Configuration details
This configuration specifies:
- alias `b` to `branch` ;
- alias `ck` to `checkout` ;
- editor is `neovim` ;
- use `neovim` as merge tool (`nvimdiff`) ;
- enables commit signature ;
- select the identity according to the current folder
