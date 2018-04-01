" .vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Author: Joshua N. Grant                                                "                       
"   Maintainer: Joshua N. Grant                                                "
"      Version: 1.0 - Fri 31 Mar 2017 10:01:32 AM EDT                          "
"     Sections:                                                                "
"               -> Initialize Vundle and Powerline                             "
"               -> General Settings                                            "
"               -> Interface Settings                                          "
"               -> Tab, Backspace, Folds                                       "
"               -> Files, Backups, and Undo                                    "
"               -> Movement Settings                                           "
"               -> Visual Mode Settings                                        "
"               -> Mappings                                                    "
"               -> Commands                                                    "
"               -> Custom Scripts                                              "
"               -> Tmux and R Support                                          "
"               -> Plugin Configurations                                       "
"                  -> Vim Startify                                             "
"                  -> Syntastic                                                "
"                  -> NERDCommenter                                            "
"                  -> UltiSnips                                                "
"                                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
Plugin 'mhinz/vim-startify'
Plugin 'vim-syntastic/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'valloric/youcompleteme'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'taglist.vim'
Plugin 'raimondi/delimitmate'
Plugin 'xolox/vim-misc'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'lervag/vimtex'
Plugin 'elzr/vim-json'
Plugin 'chrisbra/csv.vim'
Plugin 'cburroughs/pep8.py'
Plugin 'L9'
Plugin 'jalvesaq/Nvim-R'
" end vundle
call vundle#end()

" configure powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
" 1}}}
" General Settings {{{1
filetype indent plugin on
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set nostartofline
set more
set magic
set autoread
set nospell
set history=5000
set encoding=utf8
set ffs=unix,dos,mac
" 1}}}
" Interface Settings {{{1
set ruler
set showmatch
set matchtime=2
set laststatus=2
set visualbell
set noerrorbells
set confirm
set t_vb=
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set t_Co=256
set background=dark
try
   colorscheme molokai
catch
endtry

" 1}}}
" Tab, Backspace, Folds {{{1
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set tabstop=3
set shiftwidth=3
set expandtab
set foldmethod=marker
set smarttab
set smartindent
set foldcolumn=1
set autoindent
" 1}}}
" Files, Backups, and Undo {{{1
" turn off backup, since most everythign is in git anyway
set nobackup
set nowb
set noswapfile
" if vim can, give me persistent undo
if has('persistent_undo')   " only if vim supports it
   set undofile             " turn it on
   set undodir=$HOME/.vim/undo "make sure this directory exists
endif
" 1}}}
" Movement Settings {{{1
set scrolloff=7
" 1}}}
" Visual Mode Settings {{{1
" visual mode pressing * or # searches for current selection
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@<CR><CR>
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@<CR><CR>
" when you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
" 1}}}
" Mappings {{{1
inoremap jj <esc>
let mapleader = ","
let g:mapleader = ","

" R script settings
let maplocalleader = ";"
vmap <space> <Plug>RDSendSelection
nmap <space> <Plug>RDSendLine
let vimrplugin_applescript=0
let vimrplugin_vsplit=1

" faster saving with <leader>w
nmap <leader>w :w!<cr>

" ignore line wrap in line navigation
nmap j gj
nmap k gk

" Toggle NERDTree using <F3>
nnoremap <F3> :NERDTreeToggle<CR>

" Will allow you tu use :w!! to write to a file using sudo if you forgot to
" sudo vim file (it will prompt for sudo password when writing)
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/
cmap w!! %!sudo tee > /dev/null %

" use <F5> to insert current timestamp date
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime<%c")<CR>

" clear search when <leader><space> is pressed
map <silent> <leader><space> :nohl<cr>

" better tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" quickly resize vertical windows with <ALT><SHIFT> + < | >
map <M-<> <C-W><
map <M->> <C-W>>
" 1}}}
" Commands {{{1

" automatically source vimrc after changing it
autocmd! bufwritepost .vimrc source %

" remember where last edited in file
if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" indent folding with manual folds
augroup vimrc
   au BufReadPre * setlocal foldmethod=indent
   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" 1}}}
" Custom Scripts {{{1
function! CmdLine(str)
   exe "menu Foo.Bar :" . a:str
   emenu Foo.Bar
   unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
   let l:saved_reg = @"
   execute "normal! vgvy"

   let l:pattern = escape(@","\\/.*$^~[]")
   let l:pattern = substitute(l:pattern, "\n$", "", "")

   if a:direction =='gv'
      call CmdLine("Ag '". l:pattern ."' ")
   elseif a:direction =='replace'
      call CmdLine("%s" . '/'. l:pattern . '/')
   endif

   let @/ = l:pattern
   let @" = l:saved_reg
endfunction
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
" Plugin Configurations {{{1
" Vim Startify Plugin Configuration {{{2
let g:startify_bookmarks = ['~/.vimrc','~/.bashrc']
" 2}}}
" Syntastic Plugin Configuration {{{2
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" 2}}}
" NERDCommenter Plugin Configuration {{{2
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" 2}}}
" UltiSnips Configuration {{{2
let g:UltiSnipsExpandTrigger='<C-tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit="vertical"
" 2}}}
" 1}}}
" Autoread Commands {{{1
au BufReadPost,BufNewFile .*,*.conf set foldmethod=manual 
" 1}}}
