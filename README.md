# Obvious Resize

A plugin for easy resizing of Vim windows.

Just add the following into your .vimrc file:


```
noremap <silent> <C-Up> :<C-U>ObviousResizeUp<CR>
noremap <silent> <C-Down> :<C-U>ObviousResizeDown<CR>
noremap <silent> <C-Left> :<C-U>ObviousResizeLeft<CR>
noremap <silent> <C-Right> :<C-U>ObviousResizeRight<CR>
```

## Specifying the Resize Amount

Windows get resized 1 line by default, which you can change in your .vimrc file:

```
let g:obvious_resize_default = 2
```

Like most Vim commands, you can prefix your command with an optional count: `5<C-Up>` will resize by 5 lines.

You can also specify a count in your remap:

```
noremap <silent> <C-Up> :<C-U>ObviousResizeUp 5<CR>
```
