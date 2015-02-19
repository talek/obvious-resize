# Obvious Resize

A plugin for easy resizing of Vim windows.

Just add the following into your .vimrc file:


```
noremap <silent> <C-Up> :ObviousResizeUp<CR>
noremap <silent> <C-Down> :ObviousResizeDown<CR>
noremap <silent> <C-Left> :ObviousResizeLeft<CR>
noremap <silent> <C-Right> :ObviousResizeRight<CR>
```

## Specifying the Resize Amount

Windows get resized 1 line by default, which you can change in your .vimrc file:

```
let g:obvious_resize_default = 2
```

You can also specify a count in your remap:

```
noremap <silent> <C-Up> :<C-U>ObviousResizeUp 5<CR>
```
