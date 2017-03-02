set encoding=utf-8
scriptencoding utf-8

"" ESCの代替
inoremap <silent> jj <ESC>

"" Dと同じく
nnoremap Y y$
"" インクリメント
nnoremap + <C-a>
"" デクリメント
nnoremap - <C-x>
"" 検索のハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR>
"" 危険なマッピングの無効化
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

"" 行頭/行末に移動
nnoremap H 0
nnoremap L $

"" 水平分割
nnoremap s- :split<CR>
"" 垂直分割
nnoremap s\ :vsplit<CR>
"" 別のウィンドウに移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
"" 次に移動
nnoremap sw <C-w>w
"" 分割したウィンドウを移動
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
"" 回転
nnoremap sR <C-w>r
"" 大きさを揃える
nnoremap s= <C-w>=
"" 幅を増やす
nnoremap s> <C-w>>
"" 幅を減らす
nnoremap s< <C-w><
"" 高さを増やす
nnoremap s+ <C-w>+
"" 高さを減らす
nnoremap s- <C-w>-
"" 新規タブ
nnoremap st :tabnew<CR>
"" 次のタブ
nnoremap sn gt
"" 前のタブ
nnoremap sp gT
