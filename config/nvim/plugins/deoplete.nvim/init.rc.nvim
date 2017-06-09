let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_smart_case = 1
inoremap <silent><expr> <TAB> 
\  pumvisible() ? "\<C-n>" :
\  neosnippet#expandable_or_jumpable() ?
\  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
