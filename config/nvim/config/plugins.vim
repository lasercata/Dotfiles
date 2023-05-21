"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2023.05.21
" Version       :   v1.1
"
"----------------------------------------


"------Plugins
call plug#begin('~/.config/nvim/plugged')
    "---Prog
    "-UltiSnips snippets
    Plug 'sirver/ultisnips'
        let g:UltiSnipsExpandTrigger = '<tab>'
        let g:UltiSnipsJumpForwardTrigger = '<tab>'
        let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
        "let g:UltiSnipsSnippetDirectories = '~/.config/nvim/my_snippets/UltiSnips'
        let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

    "-Vimtex
    Plug 'lervag/vimtex'
        let g:vimtex_view_method = 'zathura'

    "-Vim-Slime (for ocaml)
    "Plug 'jpalardy/vim-slime'
        "let g:slime_target = "tmux"
        "let g:slime_paste_file = "$HOME/.slime_paste"


    "---Utilities
    "-ChadTree : better than NerdTree (a file explorer in a side bar)
    " Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    "     nnoremap <leader>e <cmd>CHADopen<CR>

    "-Nvim-tree (file explorer)
    Plug 'nvim-tree/nvim-tree.lua'
        nnoremap <leader>e <cmd>NvimTreeFindFileToggle<cr>

    "-Pear-tree : auto close some delimiters
    Plug 'tmsvg/pear-tree'
        let g:pear_tree_smart_openers = 1
        let g:pear_tree_smart_closers = 1
        let g:pear_tree_smart_backspace = 1
        let g:pear_tree_repeatable_expand = 0

    "-Tagbar : a class outline viewer for Vim
    Plug 'preservim/tagbar'
        nnoremap <leader>o <cmd>TagbarToggle<CR>

    "-Telescope : a fuzzy finder
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
        nnoremap <leader>f <cmd>Telescope find_files<CR>
        nnoremap <leader>b <cmd>Telescope buffers<CR>

    "-Comment.nvim : adding bindings to comment code
    Plug 'numToStr/Comment.nvim'

    "-CheatSheet : use telescope to find vim info
    Plug 'sudormrfbin/cheatsheet.nvim'
        "The default binding is <leader>?


    "---Style
    "-Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1

    "-Tmuxline
    Plug 'edkolev/tmuxline.vim'
        let g:airline#extensions#tmuxline#enabled = 1
        let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

    "-Nightfly colorscheme
    Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
        "let g:nightflyTransparent= v:true

    "-Monokai colorscheme
    Plug 'tanvirtin/monokai.nvim'
        "To keep transparency after changing the colorscheme :
        au ColorScheme * hi Normal ctermbg=none guibg=none

    "-Neoscroll : smooth scrolling
    Plug 'karb94/neoscroll.nvim'
call plug#end()

"---Plugins require
" vim.keymap.set('n', '+', api.tree.change_root_to_node, opts('CD'))

lua require('Comment').setup()
lua require('neoscroll').setup()
lua require("nvim-tree").setup()
