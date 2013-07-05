" cpp.vim - A C++ vim plugin
" John Ruffer
" public domain license

" give the user a chance to override this plugin
" set a global variable if it does not yet exist
if exists( "g:loadedCpp" )
    finish
endif

if !exists( "g:cppTemplateDir" )
    let g:cppTemplateDir = "~/.vim/cpp/templates/"
endif

let s:cppClassesDir = "classes/"
let s:cppLoopsDir = "loops/"
let s:cppConditionalsDir = "conditionals/"

let s:newHeader = "new-header.txt"
let s:newClassBody = "new-class.txt"

let g:loadedCpp = 1
" save user settings to a temporary location until the script is through
let s:savecpo = &cpo
set cpo&vim

" use this if you want to let the user define a custom mapping
" if !hasmapto( '<Plug>TestAdd' )
"     map <unique> <Leader>a <Plug>TestAdd
" endif

" <Leader> allows the user to define a leading character, e.g. underscore ()
" by default, <Leader> is a backslash (\)
" <unique> will cause an error to raise if the mapping already exists
if !hasmapto('<Plug>CppPut')
    map <unique> <Leader>put <Plug>CppPut
endif
noremap <unique> <script> <Plug>CppPut :call <SID>Put()<CR>

if !hasmapto('<Plug>CppClassHeader')
    map <unique> <Leader>ch <Plug>CppClassHeader
endif
noremap <unique> <script> <Plug>CppClassHeader :call <SID>ClassHeader()<CR>

if !hasmapto('<Plug>CppClassBody')
    map <unique> <Leader>cb <Plug>CppClassBody
endif
noremap <unique> <script> <Plug>CppClassBody :call <SID>ClassBody()<CR>

" VISUAL MODE commands
" comment block of text
vnoremap <unique> cc <Esc>:'<,'>s/^/\/\/ /g <CR>
" uncomment block of text
vnoremap <unique> uc <Esc>:'<,'>s/\/\/ //g <CR>

function s:Put()
    call append( line( "." ), "This is a test!" )
endfunction

function s:ClassHeader()
    let classname = input( "Enter class name: " )
    let templateName = g:cppTemplateDir .s:cppClassesDir . s:newHeader
    " echo templateName
    exe line( "." )-1 . "read " . expand( fnameescape( templateName ) )
    exe "%s/|CLASS|/" . toupper( classname ) . "/g"
    exe "%s/|Class|/" . classname . "/g"
endfunction

function s:ClassBody()
    let classname = input( "Enter class name: " )
    let templateName = g:cppTemplateDir .s:cppClassesDir . s:newClassBody
    " echo templateName
    exe line( "." )-1 . "read " . expand( fnameescape( templateName ) )
    exe "%s/|Class|/" . classname . "/g"
endfunction
" return settings to original state
let &cpo = s:savecpo
unlet s:savecpo
