nnoremap <silent> <Leader>o :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>b :<C-u>Denite buffer<CR>
nnoremap <silent> <Leader>dg :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>
nnoremap <silent> <Leader>dr :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>
nnoremap <silent> <Leader>dn :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=+1 -immediately<CR>
nnoremap <silent> <Leader>dp :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=-1 -immediately<CR>
