"""" nocompatible mode """""
if &compatible
  set nocompatible
endif
"""""""""""""""""""""""""""""

""""" Color Scheme """""
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256

augroup ColorSchemeSetting
  autocmd!
  au ColorSchemeSetting VimEnter * nested colorscheme solarized
augroup END
""""""""""""""""""""""""

""""" XDG Base Direcotry """""
set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
" set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set viminfo=
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
""""""""""""""""""""""""""""""

""""" Dein.vim Settings """""
let s:vim_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:vimrc = s:vim_home . 'vim/vimrc.vim'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/vim/dein'
let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_repo_dir)
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:vimrc, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"""""""""""""""""""""""""""""

""""" Common """""
filetype on
syntax on
set number
set noswapfile
set showcmd
set smartindent
set virtualedit=block
set visualbell
set laststatus=2
filetype plugin indent on
""""""""""""""""""

""""" File Type Settings """""
augroup FileTypeFormat
  autocmd!
  autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END
""""""""""""""""""""""""""""""

""""" lightline.vim """""
let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'mode_map': {'c': 'NORMAL'},
\ 'active': {
\   'left': [['mode', 'paste'], ['fugitive', 'filename']]
\ },
\ 'component_function': {
\   'modified': 'LightLineModified',
\   'readonly': 'LightLineReadOnly',
\   'fugitive': 'LightLineFugitive',
\   'filename': 'LightLineFileName',
\   'fileformat': 'LightLineFileformat',
\   'filetype': 'LightLineFiletype',
\   'fileencoding': 'LightLineFileEncoding',
\   'mode': 'LightLineMode'
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
\   (&ft == 'vimfiler' ? vimfiler#get_status_string() :
\   &ft == 'unite' ? unite#get_status_string() :
\   &ft == 'vimshell' ? vimshell#get_status_string() :
\   '' != expand('%:t') ? expand('%:t') : '[No Name]') .
\   ('' != LightLineModified() ? ' ' . LightLineModified() : '')
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
"""""""""""""""""""""""""
