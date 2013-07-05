# cpp.vim #

# Introduction #

__cpp.vim__ is simply a (growing) collection of my C++ VIM hotkeys. It's still in its infancy, but it will be expanding quickly. Heck, this project may even grow to include other languages (in which case, it would need to be renamed, hah).

## Installation ##

To install, copy the plugin directory to your .vim/ folder, and the base directory (cpp) and the subdirectory template/ into the .vim/ folder. This is the default location in which the plugin will find the templates. If you wish to keep the templates elsewhere, create a symbolic link to the cpp base directory in your .vim/ folder.

## Commands ##

__in normal mode__

+ \ch - insert a class header
+ \cb - insert a class body

__in visual mode__

+ cc - comment line/block of text
+ uc - uncomment line/block of commented text
