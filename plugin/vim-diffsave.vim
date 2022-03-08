" vim-diffsave
" View a file's diff against last disk save.
" Maintainer:   Josh Lee <llz dot joshlee at gmail dot com>
" License:      MIT

" Function to summon a diff window between current file and its disk save
function! DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    return win_getid()
endfunction

" Function to toggle between opening and closing diffsave window
function! ToggleDiffSave()
    
    " If there is a diffsave window open in this tab, close and reset diffwinid
    if exists('t:diffwinid')
        call win_execute(t:diffwinid, 'close')
        unlet t:diffwinid

    " If no such window in this tab, open one and set diffwinid
    " `!&diff` used to be included in the conditional, but for some reason it
    " won't allow some files (e.g. in other tabpages) to toggle diskdiff
    elseif &modifiable && strlen(expand('%')) > 0
        let t:diffwinid = DiffWithSaved()
    endif

endfunction

" Toggle with mappings
nmap <silent> <Plug>ToggleDiffSave :call ToggleDiffSave()
