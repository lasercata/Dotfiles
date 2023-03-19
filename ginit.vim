"--------------------------------
"
" Author            : Lasercata
" Last modification : 2023.03.19
" Version           : v1.1
"
"--------------------------------


" Enable Mouse for scrolling
set mouse=n

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Hack:h10
endif

" Enable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 1
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

" Colors
hi Statement guifg=#fdbc4b gui=none
hi PreProc guifg=#5fd7ff
hi Comment guifg=#16a085
hi Special guifg=#fdd5d5
hi Normal guifg=#1c1e1f guifg=#ffffff
hi LineNr guifg=#f9b94a

" File tree
nnoremap <C-t> :GuiTreeviewToggle<CR>
