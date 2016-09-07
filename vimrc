" .vimrc

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

" Tab, Backspace, Folds {{{1
set backspace=indent,eol,start
set tabstop=3
set shiftwidth=3
set expandtab
set foldmethod=marker

" Mappings {{{1
inoremap jj <esc>
" map <c-L> (redraw screen) to also turn off search hihglihgting
" until the next search
nnoremap <C-L> :nohl<CR><C-L>

" ignore line wrap in line navigation
nmap j gj
nmap k gk
" Commands {{{1
" automatically source vimrc after changing it
autocmd! bufwritepost .vimrc source %

" Custom Scripts {{{1

