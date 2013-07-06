" cpp.vim - A C++ vim plugin
" John Ruffer <jqruffer@gmail.com>
" GPLv3 License

" Check for a C/C++ file extension
echo &ft
if( &ft != "cpp" && &ft != "c" && &ft != "h" )
    finish
endif

" give the user a chance to override this plugin
" set a global variable if it does not yet exist
if exists( "g:loadedCpp" )
    finish
endif

" give the user a chance to disable this ftplugin
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" User may set this global variable in their .vimrc, if they wish templates to
" be in a different directory
if !exists( "g:cppTemplateDir" )
    let g:cppTemplateDir = "~/.vim/cpp/templates/"
endif

let s:cppClassesDir = "classes/"
let s:cppLoopsDir = "loops/"
let s:cppConditionalsDir = "conditionals/"

let s:newHeader = "new-header.txt"
let s:newClassBody = "new-class.txt"
let s:forLoop = "for-loop.txt"

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

" ====== NORMAL MODE commands ====== "
" Insert basic class header skeleton
if !hasmapto( '<Plug>CppClassHeader' )
    map <unique> <Leader>ch <Plug>CppClassHeader
endif
noremap <unique> <script> <Plug>CppClassHeader :call <SID>ClassHeader()<CR>

" Insert basic class body skeleton
if !hasmapto( '<Plug>CppClassBody' )
    map <unique> <Leader>cb <Plug>CppClassBody
endif
noremap <unique> <script> <Plug>CppClassBody :call <SID>ClassBody()<CR>

" Insert global include directive
if !hasmapto( '<Plug>CppGlobalInclude' )
    map <unique> <Leader>pig <Plug>CppGlobalInclude
endif
noremap <unique> <script> <Plug>CppGlobalInclude I#include <><Esc>i

" Insert local include directive
if !hasmapto( '<Plug>CppLocalInclude' )
    map <unique> <Leader>pil <Plug>CppLocalInclude
endif
noremap <unique> <script> <Plug>CppLocalInclude I#include ""<Esc>i

" Insert for loop
if !hasmapto( '<Plug>CppFor' )
    map <unique> <Leader>for <Plug>CppFor
endif
noremap <unique> <script> <Plug>CppFor :call <SID>CompleteFor()<CR>

" ====== VISUAL MODE commands ====== "
" comment block of text
vnoremap <unique> cc <Esc>:'<,'>s/^/\/\/ /g <CR>
" uncomment block of text
vnoremap <unique> uc <Esc>:'<,'>s/\/\/ //g <CR>

" ====== HELPER FUNCTIONS ====== "
function s:ClassHeader()
    let classname = input( "Enter class name: " )
    let templateName = g:cppTemplateDir .s:cppClassesDir . s:newHeader
    exe line( "." )-1 . "read " . expand( fnameescape( templateName ) )
    exe "%s/|CLASS|/" . toupper( classname ) . "/g"
    exe "%s/|Class|/" . classname . "/g"
endfunction

function s:ClassBody()
    let classname = input( "Enter class name: " )
    let templateName = g:cppTemplateDir .s:cppClassesDir . s:newClassBody
    exe line( "." )-1 . "read " . expand( fnameescape( templateName ) )
    exe "%s/|Class|/" . classname . "/g"
endfunction

function s:CompleteFor()
    let templateName = g:cppTemplateDir .s:cppLoopsDir . s:forLoop
    exe line( "." )-1 . "read " . expand( fnameescape( templateName ) )
    :redraw!
    for i in [1,2,3]
        exe "normal! /<--->/b\<CR>5s"
        :redraw!
        let c = nr2char( getchar() )
        while c != "\<Tab>" && c != "\<Esc>"
            exe "normal! a" . c
            :redraw!
            let c = nr2char( getchar() )
            " TODO FIX ME TO USE BACKSPACE!!!
            if c == "\b"
                echo "Yay!"
                :normal! a<BS>
            endif
        endwhile

        if c == "\<Esc>"
            break
        endif
    endfor
    exe "normal! \<Esc>jI\<Tab>"
endfunction

" return settings to original state
let &cpo = s:savecpo
unlet s:savecpo
