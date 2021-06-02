if exists("g:nerdtree_vide") && g:nerdtree_vide ==# 1
    function! NvrRemote()
        let file = g:NERDTreeFileNode.GetSelected()
        if getline(".") ==# g:NERDTreeUI.UpDirLine()
            silent call nerdtree#ui_glue#upDir(0)
            return
        endif
        if isdirectory(file.path.str())
            call nerdtree#ui_glue#invokeKeyMap("<CR>")
            return
        endif

        silent exe ':!"nvr"'." --servername /tmp/nvimsocket --remote-silent"." ".file.path.str()." 2>/dev/null"
    endfunction

    set noshowmode
    set noruler
    set laststatus=0
    set showtabline=0
    set noshowcmd
    set cmdheight=1

    let g:airline#extensions#tabline#enabled = 0
    let g:airline#extensions#bufferline#enabled = 0
    let g:airline#extensions#tabline#show_buffers = 0

    au FileType nerdtree nmap <buffer> <silent> <CR> :call NvrRemote()<CR>
endif
