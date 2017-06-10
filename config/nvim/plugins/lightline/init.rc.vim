let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'mode_map': {'c': 'NORMAL'},
\ 'active': {
\   'left': [['mode', 'paste', 'ale'], ['fugitive', 'filename']]
\ },
\ 'component_function': {
\   'modified': 'LightLineModified',
\   'readonly': 'LightLineReadOnly',
\   'fugitive': 'LightLineFugitive',
\   'filename': 'LightLineFileName',
\   'fileformat': 'LightLineFileformat',
\   'filetype': 'LightLineFiletype',
\   'fileencoding': 'LightLineFileEncoding',
\   'mode': 'LightLineMode',
\   'ale': 'ALEStatus'
\ }
\}
function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadOnly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightLineFileFormat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! ALEstatus()
  return ALEGetStatusLine()
endfunction
