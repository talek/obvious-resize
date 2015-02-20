" Description: Obvious-Resize autoload buddy.
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>

if &cp || exists("g:_loaded_obviousresize") 
 finish
endif
let g:_loaded_obviousresize = 1

if !exists("g:obvious_resize_default")
  let g:obvious_resize_default = 2
endif

let s:cpo_save = &cpo
set cpo&vim

" Whenever or not there is a window on the provided side.
function! s:HasWindow(side)
  " ignore events
  let _eventignore = &eventignore
  set eventignore=all
  let result = 0
  let crr_win = winnr()
  exe 'wincmd ' . a:side
  if winnr() != crr_win
    let result = 1
    exe crr_win . 'wincmd w'
  endif
  let &eventignore = _eventignore
  return result
endfunction

" Resize the current window at the provided direction
function! obviousresize#Resize(dir, ...)
  if v:count
    let counter = v:count
  elseif a:0 == 1
    let counter = a:1
  else
    let counter = g:obvious_resize_default
  endif
  let crr_win = winnr()

  if a:dir == 'h'
    " resize to the left
    if s:HasWindow('h') && !s:HasWindow('l')
      " it has an window on the left but not on the right
      exe counter . 'wincmd >'
    elseif s:HasWindow('h') && s:HasWindow('l')
      " it has an window on the left and on the right. 
      wincmd l
      exe counter . 'wincmd >'
      exe crr_win . 'wincmd w'
    elseif s:HasWindow('l') && !s:HasWindow('h')
      exe counter . 'wincmd <'
    endif
  elseif a:dir == 'l'
    if s:HasWindow('l') && !s:HasWindow('h')
      " it has an window on the right but no window on the left
      exe counter . 'wincmd >'
    elseif s:HasWindow('l') && s:HasWindow('h')
      wincmd l
      exe counter . 'wincmd <'
      exe crr_win . 'wincmd w'
    elseif s:HasWindow('h') && !s:HasWindow('l')
      exe counter . 'wincmd <'
    endif
  elseif a:dir == 'k'
    if s:HasWindow('j') && !s:HasWindow('k')
      exe counter . 'wincmd -'
    elseif s:HasWindow('j') && s:HasWindow('k')
      wincmd j
      exe counter . 'wincmd +'
      exe crr_win . 'wincmd w'
    elseif s:HasWindow('k')
      exe counter . 'wincmd +'
    elseif s:HasWindow('j')
      wincmd j
      exe counter . 'wincmd +'
      exe crr_win . 'wincmd w'
    endif
  elseif a:dir == 'j'
    if s:HasWindow('j')
      exe counter . 'wincmd +'
    elseif s:HasWindow('k')
      wincmd k
      exe counter . 'wincmd +'
      exe crr_win . 'wincmd w'
    endif
  endif
endfunction

let &cpo=s:cpo_save
unlet s:cpo_save
