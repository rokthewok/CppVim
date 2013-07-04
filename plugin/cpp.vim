" cpp.vim - A C++ vim plugin
" John Ruffer
" public domain license

" give the user a chance to override this plugin
" set a global variable if it does not yet exist
if exists( "g:loaded_cpp" )
	finish
endif

let g:loaded_cpp = 1
" save user settings to a temporary location until the script is through
let s:save_cpo = &cpo
set cpo&vim

" <Leader> allows the user to define a leading character, e.g. underscore (_)
" by default, <Leader> is a backslash (\)
" <unique> will cause an error to raise if the mapping already exists
if !hasmapto('<Plug>CppPut')
	map <unique> <Leader>put <Plug>CppPut
endif
noremap <unique> <script> <Plug>CppPut :call <SID>Put()<CR>

" alternatively, use
" if !hasmapto( '<Plug>TestAdd' )
" 	map <unique> <Leader>a <Plug>TestAdd
" endif
" if you want to let the user define a custom mapping

function s:Put()
	call append( line( "." ), "This is a test!" )
endfunction

" return settings to original state
let &cpo = s:save_cpo
unlet s:save_cpo
