" enforce no compatible mode
set nocp

" configure status line
" always display the status line
set laststatus=2
" status line left
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fenc!=''?&fenc:&enc},     " encoding
set statusline+=%{&fileformat}]              " file format
" status line right
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" syntax on by default
syntax on

" utf8 please
set tenc=utf-8
set fenc=utf-8
set enc=utf-8
set termencoding=utf-8

" color scheme
colorscheme mustang
hi CursorLine cterm=none " Overwrite cursor line style
set cursorline
set t_Co=256
