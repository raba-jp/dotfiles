""""" ColorScheme """""
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256

augroup AutoCmd
  autocmd!
  au AutoCmd VimEnter * nested colorscheme solarized
augroup END
"""""""""""""""""""""""

""""" File Type Settings """""
augroup FileTypeFormat
  autocmd!
  autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END
""""""""""""""""""""""""""""""

""""" Dein.vim Settings """""
if &compatible
  set nocompatible
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CAHCE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_repo_dir)
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, ['~/.config/nvim/init.vim', s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"""""""""""""""""""""""""""""

""""" lightline.vim Settings """""
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'LightLineModified',
  \   'readonly': 'LightLineReadonly',
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode': 'LightLineMode'
  \ }
  \ }
""""""""""""""""""""""""""""""""""

""""" vim-watchdogs Settings """""
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_CursorHold_enable = 1
""""""""""""""""""""""""""""""""""

""""" vim-watchdogs & vim-quickrun Settings """""
let g:quickrun_config = {
\   '_': {
\     'runner': 'vimproc',
\     'runner/vimproc/updatetime' : 40,
\     'outputter/buffer/split': ':botright 4sp',
\   },
\   'watchdogs_checker/_': {
\     'outputter/quickfix/open_cmd': '',
\     'hook/qfsigns_update/enable_exit': 1,
\     'hook/qfsigns_update/priority_exit': 3,
\   },
\   'javascript/watchdogs_checker': {
\     'type': 'eslint'
\   },
\     'ruby/watchdogs_checker': {
\     'type': 'rubocop'
\   }
\ }

call watchdogs#setup(g:quickrun_config)
"""""""""""""""""""""""""""""""""""""""""""""""""

""""" Unite.vim Settings """""
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
nnoremap <silent> <buffer> <Space>u :<C-u>Unite file<CR>
nnoremap <silent> <buffer> <Space>h :<C-u>Unite history/yank<CR>
nnoremap <silent> <buffer> <Space>m :<C-u>Unite file_mru<CR>
""""""""""""""""""""""""""""""

""""" deoplete.nvim Settings """""
let g:deoplete#enable_at_startup = 1
""""""""""""""""""""""""""""""""""
set number
set fenc=utf-8
set noswapfile
set showcmd
set smartindent
set virtualedit=onemore
set visualbell
set laststatus=2
filetype plugin indent on
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
set relativenumber number




augroup AlpacaTags
  autocmd!
  if exists(':Tags')
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
    autocmd BufWritePost * TagsUpdate
  endif
augroup END

" Clipboard settings
set clipboard+=unnamedplus

" Python3 support
let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'

" Command Line Mode settings
set wildmenu





function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightLineFileformat()
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
