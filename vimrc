" .vimrc
" Initialize Vundle and Powerline {{{1
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'ervandew/screen'
Plugin 'scrooloose/nerdtree'
" end vundle
call vundle#end()

" configure powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
" 1}}}
" General Settings {{{1
filetype indent plugin on
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set autoindent
set nostartofline
set nospell
" 1}}}
" Interface Settings {{{1
set ruler
set laststatus=2
set visualbell
set confirm
set t_vb=
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set t_Co=256
set background=dark
colorscheme molokai

" 1}}}
" Tab, Backspace, Folds {{{1
set backspace=indent,eol,start
set tabstop=3
set shiftwidth=3
set expandtab
set foldmethod=marker

" 1}}}
" Mappings {{{1
inoremap jj <esc>
" map <c-L> (redraw screen) to also turn off search hihglihgting

" until the next search
nnoremap <C-j> :nohl<CR><C-L>

" R script settings
let maplocalleader = ","
vmap <space> <Plug>RDSendSelection
nmap <space> <Plug>RDSendLine
let vimrplugin_applescript=0
let vimrplugin_vsplit=1

" ignore line wrap in line navigation
nmap j gj
nmap k gk

" 1}}}
" Commands {{{1

" automatically source vimrc after changing it
autocmd! bufwritepost .vimrc source %

" indent folding with manual folds
augroup vimrc
   au BufReadPre * setlocal foldmethod=indent
   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" 1}}}
" Custom Scripts {{{1

" 1}}}
" Tmux and R Support {{{1
let g:ScreenImpl = 'Tmux'
let vimrplugin_screenvsplit = 1
let g:ScreenShellInitialFocus = 'shell'
" Instruct to use your own .screenrc file
let g:vimrplugin_noscreenrc = 1
" don't use conque shell if installed
let vimrplugin_conqueplugin = 0
" map the r to send visually selected lines to R
let g:vimrplugin_map_r = 1
" see R documentation in a vim buffer
let vimrplugin_vimpager = "no"
" let me use underscore
let vimrplugin_assign = 0
" start R with F2 key
map <F2> <Plug>RStart
imap <F2> <Plug>RStart
vmap <F2> <Plug>Rstart
" send selection to R with space bar
vmap <Space> <Plug>RDSendSelection
" send line to R with space bar
nmap <Space> <Plug>RDSendLine

" 1}}}
