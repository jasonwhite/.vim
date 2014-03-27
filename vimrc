"
" My glorious .vimrc file. Behold its majesty.
"
set nocompatible
set encoding=utf-8


" Pathogen must be initialized before syntax highlighting and filetype
" detection.
call pathogen#infect()
call pathogen#helptags()


syntax enable

filetype on
filetype plugin on
filetype indent on


"
" Options
"
set autoindent
set autoread
set backspace=indent,eol,start
set clipboard^=unnamed
set expandtab
set fileformats=unix,dos
set laststatus=2
set nowrap
set number
set ruler
set scroll=8
set scrolloff=8
set shiftwidth=4
set showtabline=2
set sidescroll=1
set sidescrolloff=12
set smartindent
set softtabstop=4
set splitright
set synmaxcol=128
set tabstop=4
set textwidth=80
set timeoutlen=500
set virtualedit=block

" Need a more POSIX compatible shell
if &shell =~# 'fish$'
    set shell=sh
endif

" Save undo history.
set undofile
if has('win32')
	set undodir=$HOME\\vimfiles\\undo
else
	set undodir=$HOME/.vim/undo
endif
if !isdirectory(&undodir)
	call mkdir(&undodir)
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
iab lau lua
iab Lau Lua


"
" Mappings
"

let mapleader = ';'

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

" Switch to last active tab
let g:lasttab = 1
nmap <silent> <leader>tl :exe "tabn ". g:lasttab<CR>

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


"
" Plugin mappings
"

" NERDTree
nnoremap <silent> <F1> :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>

" NERDCommenter
map <silent> - <leader>c<space>

" TagList
nnoremap <silent> <F8> :TlistToggle<CR>

" Session Manager 2 letter shortcuts
command! -bar -bang -nargs=? -complete=customlist,xolox#session#complete_names SS SaveSession<bang> <args>
command! -bar -bang -nargs=? -complete=customlist,xolox#session#complete_names SO OpenSession<bang> <args>
command! -bar -bang -nargs=? -complete=customlist,xolox#session#complete_names SD DeleteSession<bang> <args>
command! -bar -bang SC CloseSession<bang>

" Align
map <leader>W= <plug>AM_w=

" airline
let g:airline_powerline_fonts = 1

"
" Commands
"

" Short copyright to use in various places. (Can be blank)
let copyright = 'Copyright (c) '. strftime('%Y') .' Jason White'

" Insert copyright string
imap <silent> <C-j>c <C-r>=copyright<CR>

" Manually trim trailing spaces
command! TTS :call s:trimtrailingspaces()



"
" Autocommands
"

augroup vimrc
	au!

	" Switching to last active tab
	au TabLeave * let g:lasttab = tabpagenr()

	" Scroll distance for CTRL-D and CTRL-U
	au WinEnter * let &scroll=winheight(0)/6

	" C++ settings
	au FileType cpp call s:ft_cpp()

	" Automatically trim trailing spaces for certain files
	au BufWrite *.{vim,c,cpp,h,lua,php,js,d,di,tex,ltx},[._]vimrc,[._]gvimrc,bbfile call s:trimtrailingspaces()

	" Miscellaneous settings
	au FileType lua call s:ft_lua()
	au FileType vim call s:ft_vim()
	au FileType markdown call s:ft_markdown()
augroup end


function! s:ft_cpp()
	vmap <buffer> <silent> <leader>ac :call <SID>align('^\(.\{-}\)\(\s*\)\(//.*\)')<CR>
endfunction

function! s:ft_vim()
	vmap <buffer> <silent> <leader>ac :call <SID>align('^\(.\{-}\)\(\s*\)\(".*\)')<CR>
endfunction

function! s:ft_lua()
	vmap <buffer> <silent> <leader>ac :call <SID>align('^\(.\{-}\)\(\s*\)\(--.*\)')<CR>
endfunction

function! s:ft_markdown()
	" Smart indent mucks with paragraph formatting when a line starts with a
	" keyword from C.
	set nosmartindent
endfunction


"
" General functions
"

" Adds the specified string to the beginning of the current line
function! s:commentline( prefix, suffix )
	let l = getline('.')
	if !empty(l) " Don't comment empty lines
		call setline( '.', a:prefix . l . a:suffix )
	endif
endfunction

" Removes the specified pattern (if any) from the beginning of the current line
" or range of lines (in visual mode).
function! s:uncommentline( pat )
	call setline( '.', substitute( getline('.'), '^\(\s*\)'.a:pat, '\1', '' ) )
endfunction

" Do a substitution on the current line
function! s:subline( pat, sub, flags )
	call setline( '.', substitute( getline('.'), a:pat, a:sub, a:flags ) )
endfunction

" Wrap selected text with a prefix and suffix
function! s:wraptext( prefix, suffix ) range
	call setline( a:firstline, a:prefix . getline(a:firstline) )
	call setline( a:lastline, getline(a:lastline) . a:suffix )
endfunction

" Fills a string with tabs and spaces to the specified virtual column
function! s:tabfill( colstart, colend )
	"if &expandtab
		" Fill with spaces only.
		return repeat( ' ', a:colend - a:colstart )
	"endif

	let ntabs = 0
	let i = a:colstart

	" Fill with tabs
	while ( a:colend - i ) >= &tabstop
		let i += &tabstop - ( i % &tabstop )
		let ntabs += 1
	endwhile

	" Fill the rest with spaces
	let nspaces = a:colend - i

	return repeat("\t", ntabs) . repeat(' ', nspaces)
endfunction

" Called when a file is sent to Vim from Visual Studio
function! SendToVimualStudio( line, col )
	call cursor( a:line, a:col )
	call foreground() " Unfortunately, this doesn't always work
endfunction

" Trim trailing spaces in the entire file
function! s:trimtrailingspaces()
	let s = getreg( '/', 1 )
	let view = winsaveview()

"	execute (a:firstline+1).','.a:lastline .'substitute/\s\+$//e'
	execute '%substitute/\s\+$//e'
	execute 'nohlsearch'

	call winrestview( view )
	call setreg( '/', s )
endfunction


"
" Text alignment
"

" Aligns text according to a pattern. The pattern must consist of 3 sub-matches.
" The first two sub-matches are aligned to the right-most third sub-match.
" Based off the function in the (wonderful) IBM article:
" http://www.ibm.com/developerworks/linux/library/l-vim-script-4/index.html
function! s:align( pattern ) range
	" Column at which to align to
	let alignto = 0

	" Get the lines that need to be aligned
	let lines = []
	for lnum in range( a:firstline, a:lastline )
		let linetext = getline( lnum )
		let fields = matchlist( linetext, a:pattern )

		if !empty(fields)
			" Get the line to align to
			let left_width = strdisplaywidth( fields[1] . fields[2] )
			let alignto = max( [alignto, left_width] )

			call add( lines, { 'line':lnum, 'lval':fields[1], 'rval':fields[3] } )
		end
	endfor

	" Align the lines
	for l in lines
		call setline( l.line, l.lval . s:tabfill(strdisplaywidth(l.lval),alignto) . l.rval )
	endfor
endfunction

" Align defines
vmap <silent> <leader>ad :call <SID>align('^\(\s*#\s*define\s\+\I\i*\%((.\{-})\)\?\)\(\s\+\)\(.*\)')<CR>

" Align assignments
vmap <silent> <leader>aa :call <SID>align('^\(.\{-}\)\(\s\+\)\(=.*\)')<CR>

" Align indentations
vmap <silent> <leader>ai :call <SID>align('^\(\)\(\s*\)\(.*\)')<CR>


"
" Word Highlighting
"

" Highlight the word under the cursor just once
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


"
" Modify the GUI tab naming convention
"
function! GuiTabLabel()
	let label = ''
	let bufnrlist = tabpagebuflist( v:lnum )

	" Append tab number
	let label .= tabpagenr() .'. '

	" Append the buffer name
	let bufname = bufname( bufnrlist[tabpagewinnr(v:lnum)-1] )
	let label .= substitute( bufname, '.*[/\\]', '', '' )

	" Add '+' if one of the buffers in the tab page is modified
	for bufnr in bufnrlist
		if getbufvar( bufnr, "&modified" )
			let label .= ' +'
			break
		endif
	endfor

	" Append the number of windows in the tab page if more than one
	let wincount = tabpagewinnr( v:lnum, '$' )
	if wincount > 1
		let label .= ' ('. tabpagewinnr( v:lnum, '$' ) .')'
	endif

	return label
endfunction

set guitablabel=%{GuiTabLabel()}


"
" Automatically highlights hex values. Useful for developing color schemes.
"
" From: http://www.vim.org/scripts/script.php?script_id=2937
" By:	Yuri Feldman <feldman.yuri1@gmail.com>
"
" Modified by myself to work only for the current window.
"
function! s:hexhighlight()
	if has('gui_running')
		if !exists('w:hexcolored')
			let w:hexcolors = []
			let groupid = 4
			let nline = 0
			let nlines = line('$')

			while nline <= nlines
				let line = getline( nline )
				let linematchid = 1

				while match( line, '#\x\{6}', 0, linematchid ) != -1
					let hexval = matchstr( line, '#\x\{6}', 0, linematchid )
					exe 'hi hexColor'. groupid .' guifg='. hexval .' guibg='. hexval
					let matchid = matchadd( 'hexColor'. groupid, hexval, 25, groupid )
					let w:hexcolors += ['hexColor'. groupid]
					let groupid += 1
					let linematchid += 1
				endwhile

				let nline += 1
			endwhile

			let w:hexcolored = 1
			echo "Highlighting hex colors..."
		else
			for hexColor in w:hexcolors
				exe 'highlight clear '.hexColor
			endfor
			call clearmatches()
			unlet w:hexcolored
			unlet w:hexcolors
			echo "Unhighlighting hex colors..."
		endif
	else
		echo "HexHighlight only works with a graphical version of vim"
	endif
endfunction
