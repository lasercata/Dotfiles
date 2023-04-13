# Neovim configuration files
## Neovim
The default configuration file for NeoVim is `~/.config/nvim/init.vim` (on Linux). You can add to the end of this file the command
```vim
source ~/.vimrc
```
and download the `vimrc` file from this repository and put it in the file `~/.vimrc`.

To install the plugins, run `:PlugInstall` in nvim.


## neovim-qt
The file `ginit.vim` is the configuration file for `neovim-qt` and should be at `~/.config/nvim/ginit.vim` (for Linux).

See [https://github.com/equalsraf/neovim-qt](https://github.com/equalsraf/neovim-qt).


## Snippets
There is currently one snippet file, `tex.snippet` that contain LaTeX snippets, some of which are for macros defined in [my LaTeX template](https://github.com/lasercata/LaTeX_Templates).

Add the folder `my_snippets` to `~/.config/nvim/my_snippets`.

See [https://github.com/sirver/ultisnips/](https://github.com/sirver/ultisnips/).
