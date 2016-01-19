"
" My glorious .vimrc file. Behold its majesty!
"
set nocompatible
set encoding=utf-8
let mapleader = ';'

"
" Set up Vundle plugins
"
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-markdown'
Plugin 'JesseKPhillips/d.vim'
Plugin 'dag/vim-fish'
Plugin 'jasonwhite/vim-whitenight'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'digitaltoad/vim-jade'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'godlygeek/tabular'
"Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'wting/rust.vim'
Bundle 'zah/nimrod.vim'

call vundle#end()

" Install with :PluginInstall

filetype plugin indent on
syntax enable


"
" Colorscheme
"
colorscheme whitenight


"
" Plugin configuration
"

" Powerline
let g:powerline_pycmd = "py3"

" Better Whitespace
let g:strip_whitespace_on_save              = 1
let g:better_whitespace_filetypes_blacklist = ['markdown']
command! TTS :StripWhitespace

" Airline
let g:airline_powerline_fonts = 1

" YouCompleteMe
let g:ycm_server_use_vim_stdout      = 1
let g:ycm_server_log_level           = 'debug'
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'

" InstantRst
let g:instant_rst_slow        = 1
let g:instant_rst_bind_scroll = 0
let g:instant_rst_browser     = $BROWSER

" Indent Guides
if has('gui_running')
    let g:indent_guides_enable_on_vim_startup = 1
endif
let g:indent_guides_color_change_percent = 5
let g:indent_guides_guide_size           = 1
let g:indent_guides_start_level          = 2
let g:indent_guides_exclude_filetypes    = ['help', 'nerdtree']

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0

" NERDTree
nnoremap <silent> <F1> :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>

" NERDCommenter
map <silent> - <leader>c<space>

" TagList
nnoremap <silent> <F8> :TlistToggle<CR>

" Highlight last inserted text
nnoremap gV `[v`]


"
" Options
"
set autoindent
set autoread
set backspace=indent,eol,start
set clipboard^=unnamed
set cursorline
set expandtab
set fileformats=unix,dos
set foldcolumn=1
set formatoptions=tcroqnj
set incsearch
set laststatus=2
set lazyredraw
set list listchars=tab:\ \ ,precedes:«,extends:»
set nowrap
set number
set ruler
set scroll=8
set scrolloff=8
set shiftwidth=4
set showtabline=1
set sidescroll=1
set sidescrolloff=12
set smartindent
set softtabstop=4
set splitright
set synmaxcol=1024
set tabstop=4
set textwidth=80
set timeoutlen=500
set virtualedit=block
set wildmenu

" Need a more POSIX compatible shell
if &shell =~# 'fish$'
    set shell=bash
endif

" Save undo history.
if has('persistent_undo')
    set undofile
    if has('win32')
        set undodir=$HOME\\vimfiles\\undo
    else
        set undodir=$HOME/.vim/undo
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir)
    endif
endif


if has('unnamedplus')
    set clipboard^=unnamedplus
endif


"
" Common Misspellings
"
iab teh the
iab Teh The
iab tihs this
iab Tihs This
iab taht that
iab Taht That
iab seperate separate
iab Seperate Separate
iab functino function
iab Functino Function
iab bytse bytes
iab Bytse Bytes
iab lau Lua
iab Lau Lua
iab ot to
iab Ot To


"
" Mappings
"

" Yank to the end of the line instead of the entire line
map Y y$

" Set the current working directory to the directory of the opened file
nmap <silent> <leader>cd :lcd %:p:h<CR>:pwd<CR>

" Insert a Universally Unique Identifier (UUID)
imap <C-J>u <C-r>=substitute(system("uuidgen"), '.$', '', 'g')<CR>

" Easier editing of the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" Source the current selection, or line
vmap <silent> <leader>so "zy:execute @z<CR>
nmap <silent> <leader>so "zyy:execute @z<CR>

" Faster saving
nmap <silent> <leader>w :w<CR>

" Faster quitting
nmap <silent> <leader>q :q<CR>
nmap <silent> <leader>Q :q!<CR>

" Create a new tab and move it to the end
nmap <silent> <leader>T :tabnew<CR>

" Move the tab to the end
nmap <silent> <leader>tm :tabm<CR>

" Toggle diff
nmap <silent> <leader>d :if &diff<bar>diffoff<bar>else<bar>diffthis<bar>endif<CR>

" Open the current working directory in a file explorer
if has('win32')
    nmap <silent> <leader>od :exe '!start explorer "'. shellescape(getcwd()) .'"'<CR>
endif

" Insert line break in normal mode
nnoremap <CR> i<CR><ESC>

" Insert a space in normal mode
nnoremap <space> i<space><ESC>l

" Shift-Enter to put in a new line after the current one
inoremap <S-CR> <esc>o
nnoremap <S-CR> o<esc>

" Shift-space to go to the end of the line
nnoremap <S-Space> $

" Toggle word highlighting
nmap <silent> <leader>hw :call <SID>hlwordon()<CR>
nmap <silent> <leader>hW :call <SID>hlwordoff()<CR>

" Open the file under the cursor in a new tab
nnoremap gf <C-w>gf:tabm<CR>

" Highlight hex values
nmap <silent> <Leader>hh :call <SID>hexhighlight()<CR>

" Get help on the word under the cursor
nmap <silent> <F4> :exe 'help '. expand("<cword>")<CR>

" Get the syntax highlighting group of the current item under the cursor. Very
" useful when developing a color scheme.
nmap <silent> <F5> :echo
    \  "hi<".    synIDattr(synID(line("."),col("."),1),"name") ."> "
    \ ."trans<". synIDattr(synID(line("."),col("."),0),"name") ."> "
    \ ."lo<".    synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Show the syntax groups affecting whatever is under the cursor. Also useful
" when developing a color scheme.
nmap <silent> <F6> :echo
    \ join(map(synstack(line('.'),col('.')),'synIDattr(v:val,"name")')," > ")<CR>

" Pretty print the JSON from the current line or selected lines.
nmap <leader>jt :.!python -m json.tool<CR>
vmap <leader>jt :!python -m json.tool<CR>

" Twiddle case. Press ~ in visual mode to cycle through case conversions.
function! s:twiddlecase( str )
    if a:str ==# toupper( a:str )
        let result = tolower( a:str )
    elseif a:str ==# tolower( a:str )
        let result = substitute( a:str, '\(\<\w\+\>\)', '\u\1', 'g' )
    else
        let result = toupper(a:str)
    endif

    return result
endfunction
vnoremap ~ ygv"=<SID>twiddlecase(@")<CR>Pgv

" Short copyright to use in various places. (Can be blank)
let copyright = 'Copyright (c) '. strftime('%Y') .' Jason White'

" Insert copyright string
imap <silent> <C-j>c <C-r>=copyright<CR>


"
" Autocommands
"

augroup vimrc
    au!

    " Scroll distance for CTRL-D and CTRL-U
    au WinEnter * let &scroll=winheight(0)/4

    " Smart indent mucks with paragraph formatting when a line starts with a
    " keyword from C.
    au FileType markdown set nosmartindent
augroup end


"
" Word Highlighting
"
" Highlights all instances of the word under the cursor.
"

function! s:hlwordon()
    call s:hlwordoff()
    let w:hlword = expand('<cword>')
    let w:hlwordmatch = matchadd('Search', '\<'. w:hlword .'\>' )

    " Set the search register so that n and N can be used to find additional
    " occurrences of the word.
    let @/ = '\<'. w:hlword .'\>'
endfunction

function! s:hlwordoff()
    if exists('w:hlwordmatch')
        call matchdelete( w:hlwordmatch )
        unlet w:hlwordmatch
        unlet w:hlword
    endif
endfunction
