" cpp.vim - A C++ vim plugin
" John Ruffer
" public domain license

" save user settings to a temporary location until the script is through
let s:save_cpo = &cpo
set cpo&vim


" give the user a chance to override this plugin
" set a global variable if it does not yet exist
if exists( "g:loaded_cpp" )
	finish
endif
let g:loaded_cpp = 1

	" <Leader> allows the user to define a leading character, e.g. underscore (_)
	" by default, <Leader> is a backslash (\)
	" <unique> will cause an error to raise if the mapping already exists
	map <unique> <Leader>a <Plug>TestAdd

	" alternatively, use
	" if !hasmapto( '<Plug>TestAdd' )
	" 	map <unique> <Leader>a <Plug>TestAdd
	" endif
	" if you want to let the user define a custom mapping

" return settings to original state
let &cpo = s:save_cpo
unlet s:save_cpo
