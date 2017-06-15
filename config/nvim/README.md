# NeoVim

## Key Mappings
### Normal Mode
|map|action|
|:-:|:----:|
|space|Leader|
|space space|Expand fold|
|Y|

### Insert Mode
|map|action|
|:-:|:----:|
|jj|Enter normal mode|

nnoremap Y y$
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

nnoremap H 0
nnoremap L $
