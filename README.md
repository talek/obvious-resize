#Obvious Resize

A plugin for easy resizing of Vim windows.

Just add the following into your .vimrc file:


```
noremap <silent> <C-Up> :ObviousResizeUp<CR>
noremap <silent> <C-Down> :ObviousResizeDown<CR>
noremap <silent> <C-Left> :ObviousResizeLeft<CR>
noremap <silent> <C-Right> :ObviousResizeRight<CR>
```

Optionally you can pass a count to :ObviousResize to resize the pane by that amount.

```
noremap <silent> <C-Up> :ObviousResizeUp 5<CR>
```
