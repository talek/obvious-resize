" ObviousResize: resize Vim windows in an obvious way
" Author:        Alexandru Tică
" Date:	         2011-08-24
" Copyright:     Copyright (C) 2010 Alexandru Tică
"                GPL, Version 3.0
"                http://www.gnu.org/copyleft/gpl.html

" This plugin may be used to resize Vim windows in an obvious way.
" Just add the following into your .vimrc file:
"
" noremap <silent> <C-Up> :ObviousResizeUp<CR>
" noremap <silent> <C-Down> :ObviousResizeDown<CR>
" noremap <silent> <C-Left> :ObviousResizeLeft<CR>
" noremap <silent> <C-Right> :ObviousResizeRight<CR>
"

if exists("g:loaded_obvious_resize") 
  finish
endif

" Current version
let g:loaded_obvious_resize = "1.1"

" Compatibility stuff handling
let s:keep_cpo = &cpo
set cpo&vim

" Define obvious resize mappings
if exists(':ObviousResizeLeft') != 2
  command! -nargs=0 ObviousResizeLeft :call obviousresize#Resize('h')
  nmap <unique> <script> <Plug>ObviousResizeLeft :ObviousResizeLeft<CR>
endif

if exists(':ObviousResizeRight') != 2
  command! -nargs=0 ObviousResizeRight :call obviousresize#Resize('l')
  nmap <unique> <script> <Plug>ObviousResizeRight :ObviousResizeRight<CR>
endif

if exists(':ObviousResizeUp') != 2
  command! -nargs=0 ObviousResizeUp :call obviousresize#Resize('k')
  nmap <unique> <script> <Plug>ObviousResizeUp :ObviousResizeUp<CR>
endif

if exists(':ObviousResizeDown') != 2
  command! -nargs=0 ObviousResizeDown :call obviousresize#Resize('j')
  nmap <unique> <script> <Plug>ObviousResizeDown :ObviousResizeDown<CR>
endif

" Restore compatibility flag
let &cpo = s:keep_cpo
unlet s:keep_cpo

