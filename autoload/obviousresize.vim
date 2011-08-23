" Description: Obvious-Resize autoload buddy.
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>

if &cp || exists("g:_loaded_obviousresize") 
 finish
endif

let g:_loaded_obviousresize = 1
let s:cpo_save = &cpo
set cpo&vim

" Whenever or not there is a window on the provided side.
function! s:HasWindow(side)
  let result = 0
  let crr_win = winnr()
  exe 'wincmd ' . a:side
  if winnr() != crr_win
    let result = 1
    wincmd p
  endif
  return result
endfunction

" Resize the current window at the provided direction
function! obviousresize#Resize(dir)
  if a:dir == 'h'
    " resize to the left
    if s:HasWindow('h') && !s:HasWindow('l')
      " it has an window on the left but not on the right
      wincmd >
    elseif s:HasWindow('h') && s:HasWindow('l')
      " it has an window on the left and on the right. 
      wincmd l
      wincmd >
      wincmd p
    elseif s:HasWindow('l') && !s:HasWindow('h')
      wincmd <
    endif
  elseif a:dir == 'l'
    if s:HasWindow('l') && !s:HasWindow('h')
      " it has an window on the right but no window on the left
      wincmd >
    elseif s:HasWindow('l') && s:HasWindow('h')
      wincmd l
      wincmd <
      wincmd p
    elseif s:HasWindow('h') && !s:HasWindow('l')
      wincmd <
    endif
  elseif a:dir == 'k'
    if s:HasWindow('j') && !s:HasWindow('k')
    	wincmd -
    elseif s:HasWindow('j') && s:HasWindow('k')
      wincmd -
    elseif s:HasWindow('k')
      wincmd +
    elseif s:HasWindow('j')
      wincmd j
      wincmd +
      wincmd p
    endif
  elseif a:dir == 'j'
    if s:HasWindow('j')
      wincmd +
    elseif s:HasWindow('k')
      wincmd k
      wincmd +
      wincmd p
    endif
  endif
endfunction

let &cpo=s:cpo_save
unlet s:cpo_save

