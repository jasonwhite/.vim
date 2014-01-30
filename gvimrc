"
" GVim settings
"

set spell         " Because mine isn't always rihgt.
set guioptions-=T " Disable the tool bar.
set guioptions-=m " Disable the menu bar.


augroup gvimrc
	au!

	" Maximize the window on startup
	if has('win32') && v:version >= 703
		au GUIEnter * simalt ~x
	endif
augroup end


if has('win32')
	set guifont=courier_new:h10
elseif has('unix')
	" Fall back to Monospace if the patched powerline font isn't there.
	set guifont=Source\ Code\ Pro\ for\ Powerline,monospace\ 10
	let g:Powerline_symbols = 'fancy'
endif

colorscheme whitenight
