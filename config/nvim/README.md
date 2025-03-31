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


## LSP servers
This is a list of the lsp servers configured here.
The configuration file is `~/.config/nvim/config/plugins/lsp.lua`.

To add a server for a given language, check the [server configurations readme](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) (of the `nvim-lspconfig` repo).

### Python
Uses [`pyright`](https://github.com/microsoft/pyright).

There is an arch package (`extra/pyright`).

### C
Uses [`clangd`](https://clangd.llvm.org/installation.html).

There is an arch package (part of `extra/clang`).

### Ocaml
Uses [`ocamllsp`](https://github.com/ocaml-lsp/ocaml-language-server).

It is possible to install it with `opam` :
```
opam install ocaml-lsp-server
```

### Bash
Uses [`bashls`](https://github.com/bash-lsp/bash-language-server).

There is an arch package (`extra/bash-language-server`).
It is also possible to install it with `npm` :
```
npm install -g bash-language-server
```

### LaTeX
Uses [`texlab`](https://github.com/latex-lsp/texlab).

There is an arch package (`extra/texlab`).

### cmake
Uses [`cmake-language-server`](https://github.com/regen100/cmake-language-server).

### HTML
Uses [`vscode-html-language-server`](https://github.com/hrsh7th/vscode-langservers-extracted).

It can be installed through `npm` :
```
npm install -g vscode-langservers-extracted
```

### Javascript
Uses [`tsserver`](https://github.com/typescript-language-server/typescript-language-server).

It can be installed through `npm` :
```
npm install -g typescript typescript-language-server
```

There is also an arch package (`extra/typescript-language-server`).

### Java
Uses [`jdtls`](https://projects.eclipse.org/projects/eclipse.jdt.ls)

There is a package in the AUR (`aur/jdtls`).

### SQL
Uses [`sqlls`](https://github.com/joe-re/sql-language-server).

It can be installed through `npm` :
```
npm install -g sql-language-server
```

### ASM
Uses [`asm_lsp`](https://github.com/bergercookie/asm-lsp).

It can be installed through `cargo` :
```
cargo install asm-lsp
```

### Prolog
Uses [`prolog_ls`](https://github.com/jamesnvc/lsp_server).
Depends on `swipl`.

There is an arch package (`extra/swi-prolog`).

To install the lsp server, run (in `swipl`).
```
pack_install(lsp_server).
```
