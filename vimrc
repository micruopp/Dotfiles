" .vimrc
" Vim configuration

filetype plugin on
" Enable syntax highlighting
syntax on

" Enable line and column numbers
set number
set ruler

" Change colorscheme
colorscheme peachpuff
hi StatusLine ctermbg=159 ctermfg=57

" Default tab settings
set tabstop=4
set shiftwidth=4
set expandtab

" File specific tab settings
autocmd Filetype html setlocal tabstop=2 shiftwidth=2
autocmd Filetype css setlocal tabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2

