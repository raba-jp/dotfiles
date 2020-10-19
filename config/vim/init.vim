set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('haya14busa/vim-edgemotion')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('lambdalisue/fern.vim')
  call minpac#add('lifepillar/vim-solarized8')
  call minpac#add('mattn/ctrlp-matchfuzzy')
  call minpac#add('mattn/vim-lsp-settings')
  call minpac#add('prabirshrestha/async.vim')
  call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
  call minpac#add('prabirshrestha/asyncomplete.vim')
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('sgur/ctrlp-extensions.vim')
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

let s:minpac_dir = '~/.vim/pack/minpac/opt/minpac'
if has('vim_starting')
  if !isdirectory(expand(s:minpac_dir))
    echo "Install minpac ...\n"
    execute 'silent !mkdir -p ~/.vim/pack/minpac/opt'
    execute 'silent !git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    call PackInit() | call minpac#update()
  endif
endif

set clipboard&
set clipboard+=unnamedplus

nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
inoremap <silent> jj <ESC>
nnoremap ; :
nnoremap : ;
nnoremap Y y$
nnoremap <TAB> $
nnoremap <S-TAB> 0
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap s <Nop>

let g:mapleader = "\<Space>"

set noswapfile
set smartindent
set visualbell
set hlsearch
set backspace=2
set signcolumn=yes
set ignorecase
set smartcase

filetype plugin indent on
syntax enable

"" 不要なデフォルトプラグインを無効化
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

"" Lightline.vim
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'solarized' }

"" edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

"" solarized8
set termguicolors
set background=dark
colorscheme solarized8

""vim-lsp.vim
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

"" asyncomplete.vim
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

"" True color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
