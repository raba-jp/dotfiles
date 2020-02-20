" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
endfunction

let s:denite_option_array = []
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

function s:Dgrep(...)
  if a:0 > 0
    execute(':Denite -buffer-name=grep-buffer-denite -start-filter grep -path='.a:1)
  else
    execute(':Denite -buffer-name=grep-buffer-denite -start-filter grep')
  endif
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *after* a plugin is loaded.
function! s:on_load_post()
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  " grep
  command! -nargs=? Dgrep call s:Dgrep(<f-args>)
  " show Denite grep results
  command! Dresume execute(':Denite -resume -buffer-name=grep-buffer-denite')
  " next Denite grep result
  command! Dnext execute(':Denite -resume -buffer-name=grep-buffer-denite -cursor-pos=+1 -immediately')
  " previous Denite grep result
  command! Dprev execute(':Denite -resume -buffer-name=grep-buffer-denite -cursor-pos=-1 -immediately')

  augroup denite_settings
    autocmd FileType denite call s:denite_my_settings()
  augroup END
endfunction

" This function determines when a plugin is loaded.
"
" Possible values are:
" * 'start' (a plugin will be loaded at VimEnter event)
" * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
" * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
" <filetypes> and <excmds> can be multiple values separated by comma.
"
" This function must contain 'return "<str>"' code.
" (the argument of :return must be string literal)
function! s:loaded_on()
  return 'start'
endfunction

" Dependencies of this plugin.
" The specified dependencies are loaded after this plugin is loaded.
"
" This function must contain 'return [<repos>, ...]' code.
" (the argument of :return must be list literal, and the elements are string)
" e.g. return ['github.com/tyru/open-browser.vim']
function! s:depends()
  return []
endfunction
