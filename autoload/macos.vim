let s:code_map = {
      \'''': '39',
      \'*':  '67',
      \'+':  '69',
      \',':  '43',
      \'-':  '27',
      \'.':  '47',
      \'/':  '44',
      \'0':  '29',
      \'1':  '18',
      \'2':  '19',
      \'3':  '20',
      \'4':  '21',
      \'5':  '23',
      \'6':  '22',
      \'7':  '26',
      \'8':  '28',
      \'9':  '25',
      \';':  '41',
      \'=':  '24',
      \'F1':  '122',
      \'F10':  '109',
      \'F11':  '103',
      \'F12':  '111',
      \'F13':  '105',
      \'F14':  '107',
      \'F15':  '113',
      \'F2':  '120',
      \'F3':  '99',
      \'F4':  '118',
      \'F5':  '96',
      \'F6':  '97',
      \'F7':  '98',
      \'F8':  '100',
      \'F9':  '101',
      \'[':  '33',
      \'\':  '42',
      \']':  '30',
      \'`':  '50',
      \'a':  '0',
      \'b':  '11',
      \'c':  '8',
      \'d':  '2',
      \'e':  '14',
      \'f':  '3',
      \'fn':  '63',
      \'g':  '5',
      \'h':  '4',
      \'i':  '34',
      \'j':  '38',
      \'k':  '40',
      \'l':  '37',
      \'m':  '46',
      \'n':  '45',
      \'o':  '31',
      \'p':  '35',
      \'q':  '12',
      \'r':  '15',
      \'s':  '1',
      \'t':  '17',
      \'u':  '32',
      \'v':  '9',
      \'w':  '13',
      \'x':  '7',
      \'y':  '16',
      \'z':  '6',
      \'§':  '10',
      \'⌤':  '76',
      \'⌧':  '71',
      \'forwardDelete': '117',
      \'home': '115',
      \'delete': '51',
      \'end': '119',
      \'escape': '53',
      \'left': '123',
      \'right': '124',
      \'down': '125',
      \'up': '126',
      \'linefeed': '52',
      \'option': '58',
      \'pageDown': '121',
      \'pageUp': '116',
      \'shift': '56',
      \'space': '49',
      \'tab': '48',
      \'capsLock': '57',
      \'command': '55',
      \'control':  '59',
      \'ctrl':  '59',
      \'return': '36',
      \'rightControl':  '62',
      \'rightOption': '61',
      \'rightShift':  '60',
      \}

function! macos#open(arg)
  if empty(a:arg) | return | endif
  call s:system('open ' . a:arg)
  return !v:shell_error
endfunction

function! macos#ItermOpen(dir)
  return s:osascript(
      \ 'if application "iTerm2" is not running',
      \   'error',
      \ 'end if') && s:osascript(
      \ 'tell application "iTerm2"',
      \   'tell current window',
      \     'create tab with default profile',
      \     'tell current session',
      \       'write text "cd ' . a:dir . '"',
      \       'write text "clear"',
      \       'activate',
      \     'end tell',
      \   'end tell',
      \ 'end tell')
endfunction

function! macos#keycodes(...)
  return s:osascript(
    \ 'tell application "System Events"',
    \ '  key code {' . join(map(copy(a:000), 's:code_map[v:val]'), ',') . '}',
    \ 'end tell',
    \)
endfunction

function! s:system(cmd)
  let output = system(a:cmd)
  if v:shell_error && output !=# ""
    echohl Error | echon output | echohl None
    return
  endif
  return output
endfunction

function! s:osascript(...) abort
  let args = join(map(copy(a:000), '" -e ".shellescape(v:val)'), '')
  call  s:system('osascript'. args)
  return !v:shell_error
endfunction
