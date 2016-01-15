# Vim-macos

A simple plugin tries to extract some methods for interactive with MacOS system by
generate [applescript](https://developer.apple.com/library/mac/documentation/AppleScript/Conceptual/AppleScriptX/Concepts/ScriptingOnOSX.html)
when necessary.

## API

* **macos#open(argument)** open argument(could be any path) with `open` command
* **macos#ItermOpen(dir)** active iterm2 (only support version > 2.9) and open
  directory in a new tab
* **macos#keycodes(list...)** send keycode(s) to MacOS

## Example

* Make mappings for NeteaseMusic next song, previous song and pausestart

``` VimL
nnoremap <silent> <D-[> :call macos#keycodes('option', 'command', 'left')<cr>
nnoremap <silent> <D-]> :call macos#keycodes('option', 'command', 'right')<cr>
nnoremap <silent> <D-i> :call macos#keycodes('option', 'command', 'space')<cr>
```

*Note*, MacVim is needed for command key mapping, system global shortcut of NeteaseMusic have to be activated

* A keymapping make iterm2 open directory of current file

``` VimL
nnoremap <leader>to :call macos#ItermOpen(expand('%:p:h'))<cr>
```

* A keymapping make Finder open directory of current file

``` VimL
nnoremap <leader>fo :call macos#open(expand('%:p:h'))<cr>
```

*Note*, <D-o> in MacVim only open current working directory

## New Feature

Welcome to fire a feature request in the [issue list](https://github.com/chemzqm/vim-macos/issues)
