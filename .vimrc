set number
set autoindent
set smartindent
set smarttab
set ignorecase
set incsearch
set expandtab
set hls!
set directory=$HOME/.vim/swapfiles//
set nowrap
set foldmethod=indent
set cursorline

set autochdir

set shiftwidth =2
set softtabstop=2
set tabstop    =2

map <F2> :tabnew<CR>
map <F4> :tabn<CR>
map <F3> :tabp<CR>
map GY "+y

function SetupOtrsHotkeys()
  imap ;om $Kernel::OM->Get('Kernel::System::')<Left><Left>
  imap ;err $Kernel::OM->Get('Kernel::System::Log')->Log(<CR>Priority => 'error',<CR>Message  => '',<CR>);<Up><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right>
  imap ;dmp use Data::Dumper; $Data::Dumper::Sortkeys = 1;<CR>print STDERR Dumper ;<Left>
  imap ;cnt use feature 'state'; state $COUNTER = 1; print STDERR '$COUNT = '.$COUNTER++."\n";
endfunction

function SetupPhpHotkeys()
  imap ;dmp var_dump();<Left><Left>
endfunction

" kill spaces
autocmd BufWritePre *.pl,*.t,*.pm,*.c,*.cpp,*.js,*.ts,*.java,*.php,*.sql %s/\s\+$//e
autocmd BufReadPre *.ts,*.js call TabEq2()
autocmd BufNewFile *.pl :call NewPerlScript()
autocmd BufReadPre *.pm,*.pl,*.t call SetupOtrsHotkeys()
autocmd BufReadPre *.php call SetupPhpHotkeys()
autocmd BufReadPre *.tt se syntax=html
autocmd BufReadPre /opt/otrs/* call TabEq4()

map M! :call TabEq2()<CR>
map M@ :call TabEq4()<CR>

function! TabEq2()
  set shiftwidth =2
  set softtabstop=2
  set tabstop    =2
endfunction

function! TabEq4()
  set shiftwidth =4
  set softtabstop=4
  set tabstop    =4
endfunction

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" PLUG MODULE INSTALL
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'gryf/wombat256grf'
Plug 'junegunn/vim-easy-align'
Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-eunuch'
Plug 'challenger-deep-theme/vim'

call plug#end()

colorscheme challenger_deep

function! NewPerlScript()

    call setline( line('$'), '#!/usr/bin/env perl' )
    call append( line('$'), ['', 'use strict;'] )
    call append( line('$'), [ 'use warnings;' ] )
    call append( line('$'), [ 'use v5.30;', '', '' ] )

    call cursor( line('$'), 0 )

    call feedkeys('i')
endfunction

hi Normal ctermbg=none

