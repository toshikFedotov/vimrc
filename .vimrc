"----------------------------------------"
" Autoload plugin manager
"----------------------------------------"
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"----------------------------------------"
" Setup plugins
"----------------------------------------"
call plug#begin('~/.vim/plugged')
Plug 'gryf/wombat256grf'
Plug 'junegunn/vim-easy-align'
Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-eunuch'
Plug 'challenger-deep-theme/vim'
Plug 'vim-perl/vim-perl'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'mtdl9/vim-log-highlighting'
Plug 'rakr/vim-one'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-syntastic/syntastic'
Plug 'mattn/emmet-vim'
Plug 'yko/mojo.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
call plug#end()
"----------------------------------------"
" Helpers declaration
"----------------------------------------"
function SetupPerlSettings()
  imap ;ddp use DDP; p ;<Left>
endfunction

" Run tidyall on the current buffer. If an error occurs, show it and leave it
" in tidyall.ERR, and undo any changes.
command! TidyAll :call TidyAll()
function! TidyAll()
    let cur_pos = getpos( '.' )
    let cmdline = ':1,$!tidyall --mode editor --pipe %:p 2> tidyall.ERR'
    execute( cmdline )
    if v:shell_error
        echo "\nContents of tidyall.ERR:\n\n" . system( 'cat tidyall.ERR' )
        silent undo
    endif
    call system( 'rm tidyall.ERR' )
    call setpos( '.', cur_pos )
endfunction
map <leader>t :TidyAll<cr>

function SetupOtrsHotkeys()
  imap ;om $Kernel::OM->Get('Kernel::System::')<Left><Left>
  imap ;err $Kernel::OM->Get('Kernel::System::Log')->Log(<CR>Priority => 'error',<CR>Message  => '',<CR>);<Up><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right><Right>
  call SetupPerlSettings()
endfunction

function SetupPhpHotkeys()
  imap ;dmp var_dump();<Left><Left>
endfunction

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

function! NewPerlScript()
  call setline( line('$'), '#!/usr/bin/env perl' )
  call append( line('$'), ['', 'use strict;'] )
  call append( line('$'), [ 'use warnings;' ] )
  call append( line('$'), [ 'use v5.30;', '', '' ] )
  call cursor( line('$'), 0 )
  call feedkeys('i')
endfunction
"----------------------------------------"
" Some in-vim settings
"----------------------------------------"
set number
set autoindent
set smartindent
set smarttab
set ignorecase
set incsearch
set expandtab
set hls!
set directory   =/tmp//
set nowrap
set foldmethod  =indent
set cursorline
set autochdir
set hlsearch
set shiftwidth  =2
set softtabstop =2
set tabstop     =2
set foldlevel   =10
set laststatus  =2
"----------------------------------------"
" Hotkeys
"----------------------------------------"
nmap <F2> :tabnew<CR>
nmap <F4> :tabn<CR>
nmap <F3> :tabp<CR>
xmap GY "+y
nmap M! :call TabEq2()<CR>
nmap M@ :call TabEq4()<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nmap gb :Git blame<CR>
nmap <F12> :syntax sync fromstart<CR>
nmap J <C-E>
nmap K <C-Y>
"----------------------------------------"
" Auto-execution
"----------------------------------------"
autocmd BufWritePre *.pl,*.t,*.pm,*.c,*.cpp,*.js,*.ts,*.java,*.php,*.sql FixWhitespace
autocmd BufReadPre *.ts,*.js call TabEq2()
autocmd BufNewFile *.pl :call NewPerlScript()
autocmd BufReadPre /opt/otrs/*.pm,/opt/otrs/*.pl,/opt/otrs/*.t call SetupOtrsHotkeys()
autocmd BufReadPre *.pm,*.pl,*.t :call SetupPerlSettings()
autocmd BufReadPre *.php call SetupPhpHotkeys()
autocmd BufReadPre *.tt se syntax=html
autocmd BufReadPre /opt/otrs/* call TabEq4()
autocmd BufReadPre *.log.?* se syntax=log
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'NERDTree' argv()[0] | endif
"----------------------------------------"
" Variables for plugin's settings
"----------------------------------------"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:perl_sub_signatures = 1
"----------------------------------------
" Syntastic
"----------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_python_checkers = ['python']
let g:syntastic_python_python_exec = 'python3'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 1
let g:syntastic_perl_checkers            = ['perl']
let g:syntastic_enable_perl_checker      = 1
let g:syntastic_quiet_messages           = { "type": "style"  }
let g:syntastic_perl_lib_path            = [ '/opt/otrs/', '/opt/otrs/Custom/', '/opt/otrs/Kernel/cpan-lib/' ]
"----------------------------------------
" Emmet
"----------------------------------------
let g:user_emmet_leader_key=','
"----------------------------------------
" Setup colors
"----------------------------------------
colorscheme challenger_deep
hi Normal ctermbg=none
hi Search ctermbg=LightYellow
hi Search ctermfg=Red
hi Visual term=reverse cterm=reverse guibg=Grey
hi Pmenu ctermfg=15 ctermbg=0
hi Comment ctermfg=152
