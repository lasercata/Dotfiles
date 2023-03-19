# NeoVim vimrc

This repository contain my neovim vimrc (Vim configuration file).

## Neovim configuration file
The default configuration file for NeoVim is `~/.config/nvim/init.vim` (on Linux). You can add to the end of this file the command
```vim
source ~/.vimrc
```
and download the `vimrc` file from this repository and put it in the file `~/.vimrc`.


## neovim-qt template
The file `ginit.vim` is the configuration file for `neovim-qt` and should be at `~/.config/nvim/ginit.vim` (for Linux).

See [https://github.com/equalsraf/neovim-qt](https://github.com/equalsraf/neovim-qt).


## Snippets
There is currently two snippets, `all.snippets` that contain definition for auto closing parenthesis, braces, ..., and `tex.snippet` that contain LaTeX snippets (some need to use [this](https://github.com/lasercata/LaTeX_Templates) template).

Add the folder `my_snippets` to `~/.config/nvim/my_snippets`.

See [https://github.com/sirver/ultisnips/](https://github.com/sirver/ultisnips/).

## Tmux
[Tmux](https://github.com/tmux/tmux/wiki) is a terminal multiplexer.


The file `tmux.conf` from this repository is a configuration file for tmux (should be located at `~/.tmux.conf`) that define vim-like commands.
