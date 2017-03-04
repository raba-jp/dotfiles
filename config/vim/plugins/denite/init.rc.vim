nnoremap <silent> <Leader>do :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>dm :<C-u>Denite file_mru<CR>
nnoremap <silent> <Leader>dy :<C-u>Denite neoyank<CR>
nnoremap <silent> <Leader>dl :<C-u>Denite line<CR>
nnoremap <silent> <Leader>dg :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>
nnoremap <silent> <Leader>dr :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>
nnoremap <silent> <Leader>dn :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=+1 -immediately<CR>
nnoremap <silent> <Leader>dp :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=-1 -immediately<CR>
