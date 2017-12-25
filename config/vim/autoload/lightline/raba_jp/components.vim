scriptencoding utf-8

function! lightline#raba_jp#components#filename() abort
  if &filetype ==# 'denite'
    return ''
  endif
  return '' !=# expand('%:t') ? expand('%:t') : '[No Name]'
endfunction

function! lightline#raba_jp#components#mode() abort
  if &filetype ==# 'denite'
    let l:mode_str = substitute(denite#get_status_mode(), '-\\| ', '', 'g')
    call lightline#link(tolower(l:mode_str[0]))
    return l:mode_str
  endif

  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! lightline#raba_jp#components#denite_source() abort
  return &filetype ==# 'denite' ? denite#get_status_sources() : ''
endfunction

function! lightline#raba_jp#components#ale_error() abort
  return s:ale_string(0)
endfunction

function! lightline#raba_jp#components#ale_warning() abort
  return s:ale_string(1)
endfunction

function! lightline#raba_jp#components#ale_ok() abort
  return s:ale_string(2)
endfunction

function! s:ale_string(mode)
  if !exists('g:ale_buffer_info')
    return ''
  endif

  let l:counts = ale#statusline#Count(bufnr('%'))
  let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format

  if a:mode == 0 " Error
    return l:counts.0 ? printf(l:error_format, l:counts.0) : ''
  elseif a:mode == 1 " Warning
    return l:counts.1 ? printf(l:warning_format, l:counts.1) : ''
  endif

  return l:counts.total == 0 ? l:no_errors : ''
endfunction
