" .vimrc
" initialize Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/Vim-R-plugin'

call vundle#end()

" configure powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim

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
nnoremap <C-L> :nohl<CR><C-L>

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

