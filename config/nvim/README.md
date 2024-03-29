# Neovim configuration files
## Neovim
On Linux, Neovim configuration files are located at `~/.config/nvim/`.

My configuration file is split in multiple files in the `nvim/config/` folder, and are sourced by the file `nvim/init.vim`.

I use [vim-plug](https://github.com/junegunn/vim-plug) as my plugin manager in the configuration file.

To install the plugins, run `:PlugInstall` in nvim.


## neovim-qt
The file `ginit.vim` is the configuration file for `neovim-qt` and should be at `~/.config/nvim/ginit.vim` (for Linux).

See [https://github.com/equalsraf/neovim-qt](https://github.com/equalsraf/neovim-qt).


## Snippets
I use [ultisnips](https://github.com/sirver/ultisnips/) as a snippet engine.

Snippets :
- `all.snippets` : contain just `date` that expand to the date, e.g `2023.09.12` ;
- `c.snippets` : contain `main`, `fn` (function with interactive docstring), `if`, ... ;
- `python.snippets` : contain `class`, `def` (both with interactive docstring), `#!`, ... ;
- `tex.snippets` : contain my LaTeX snippets, some of which are for macros defined in [my LaTeX template](https://github.com/lasercata/LaTeX_Templates).

Add the folder `my_snippets` to `~/.config/nvim/my_snippets`.

See [https://github.com/sirver/ultisnips/](https://github.com/sirver/ultisnips/).
