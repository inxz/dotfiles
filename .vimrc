" enforce no compatible mode
set nocp

" configure status line
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" syntax on by default
syntax on

" color scheme
colorscheme mustang
hi CursorLine cterm=none " Overwrite cursor line style
set cursorline
