"
" GVim settings
"

set spell         " Because mine isn't always rihgt.
set guioptions-=T " Disable the tool bar.
set guioptions-=m " Disable the menu bar.
set guioptions-=e " Don't show the GTK tabline

" Set font.
if has('win32')
	set guifont=Source_Code_Pro_for_Powerline:h10,courier_new:h10
elseif has('unix')
	" Fall back to Monospace if the patched powerline font isn't there.
	set guifont=Source\ Code\ Pro\ for\ Powerline\ 10,Monospace\ 10
endif

" Map keys to adjusting the font size.
if has("gui_gtk2")
    let s:guifont = &guifont

    function! s:AdjustFontSize(amount)
        let &guifont = substitute(
            \ &guifont,
            \ '\zs\d\+',
            \ '\=eval(submatch(0)+'. a:amount .')',
            \ 'g')
    endfunction

    function! s:ResetFontSize()
        let &guifont = s:guifont
    endfunction

    nnoremap <silent> <PageUp> :call <SID>AdjustFontSize(1)<CR>
    nnoremap <silent> <PageDown> :call <SID>AdjustFontSize(-1)<CR>
    nmap <silent> <Home> :call <SID>ResetFontSize()<CR>
endif
