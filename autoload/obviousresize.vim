" Description: Obvious-Resize autoload buddy.
" Mainainder: Alexandru Tica <alexandru.tica.at.gmail.com>

if &cp || exists("g:_loaded_obviousresize")
 finish
endif
let g:_loaded_obviousresize = 1

if !exists("g:obvious_resize_default")
  let g:obvious_resize_default = 1
endif

if !exists("g:obvious_resize_run_tmux")
  let g:obvious_resize_run_tmux = 0
endif

let s:cpo_save = &cpo
set cpo&vim

function! s:TmuxCommand(args)
  if !g:obvious_resize_run_tmux
    return
  end

  let cmd = 'tmux -S ' . split($TMUX, ',')[0] . ' ' . a:args
  if exists('*jobstart')
    call jobstart(cmd)
  elseif executable('tmux')
    call system(cmd)
  endif
endfunction

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
    " resize left
    if s:HasWindow('h') && !s:HasWindow('l')
      " right window
      exe counter . 'wincmd >'
    elseif s:HasWindow('h') && s:HasWindow('l')
      " middle window
      exe counter . 'wincmd <'
    elseif s:HasWindow('l') && !s:HasWindow('h')
      " left window
      exe counter . 'wincmd <'
    else
      " only window
      call s:TmuxCommand('resize-pane -L ' . counter)
    endif
  elseif a:dir == 'l'
    " resize right
    if s:HasWindow('l') && !s:HasWindow('h')
      " left window
      exe counter . 'wincmd >'
    elseif s:HasWindow('l') && s:HasWindow('h')
      " middle window
      exe counter . 'wincmd >'
    elseif s:HasWindow('h') && !s:HasWindow('l')
      " right window
      exe counter . 'wincmd <'
    else
      " only window
      call s:TmuxCommand('resize-pane -R ' . counter)
    endif
  elseif a:dir == 'j'
    " resize down
    if s:HasWindow('j') && !s:HasWindow('k')
      " top window
      exe counter . 'wincmd +'
    elseif s:HasWindow('j') && s:HasWindow('k')
      " middle window
      exe counter . 'wincmd +'
    elseif !s:HasWindow('j') && s:HasWindow('k')
      " botom window
      exe counter . 'wincmd -'
    else
      " only window
      call s:TmuxCommand('resize-pane -D ' . counter)
    endif
  elseif a:dir == 'k'
    " resize up
    if s:HasWindow('k') && !s:HasWindow('j')
      " bottom window
      exe counter . 'wincmd +'
    elseif s:HasWindow('k') && s:HasWindow('j')
      " middle window
      exe counter . 'wincmd -'
    elseif !s:HasWindow('k') && s:HasWindow('j')
      " top window
      exe counter . 'wincmd -'
    else
      " only window
      call s:TmuxCommand('resize-pane -U ' . counter)
    endif
  endif
endfunction

let &cpo=s:cpo_save
unlet s:cpo_save
