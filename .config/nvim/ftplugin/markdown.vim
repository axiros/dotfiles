setlocal wrap linebreak
setlocal colorcolumn=0
colorscheme iceberg

"autocmd BufRead,BufNewFile   *.md let g:pencil_higher_contrast_ui = 1
let g:markdown_fenced_languages = ['html', 'python', 'json', 'bash=sh', 'js=javascript']
set foldcolumn=2
let g:markdown_folding=1

" Folding
" Function for markdown folding
function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
        return "="
    else
        return ">" . len(h)
    endif
endfunction

set foldmethod=syntax

setlocal foldmethod=expr foldlevel=1

setlocal foldexpr=MarkdownLevel()
"au BufNewFile,BufRead *.md,*.markdown set wrap linebreak nolist
setlocal filetype=ghmarkdown
setlocal foldlevel=2

" at a closing bracket of a markdown link hit ,ar (in insert mode still).
" It will copy the word within
" the [] and append an identical set of brackets after it (lp after jumping
" back to the end via %. Then it call the browser open stuff from autolink
" plugin. choose the link and hit enter in vim.
" This is an insert mode only map
"imap <Leader>ar []<Esc>hh%lyi[h%lpla <Esc>mlGo[<Esc>pa]: <Esc>i
" external link:
imap <Leader>el []<Esc>hh%lyi[h%lp:call AutoLink()<CR>

" internal link:
imap <Leader>il []<Esc>hh%lyi[h%lp:call AutoLinkNoSearch()<CR>


:function AutoLink()
    " autolink plugin, does it in python:
    :call autolink#Search()
    :let cmd = input("Choose link in browser then Enter - " , "call autolink#CombinedBrowser()")
    :exe cmd
    " go back to link def
    :normal A
:endfunction

:function AutoLinkNoSearch()
    :let cmd = input("Choose link in browser then Enter - " , "call autolink#CombinedBrowser()")
    :exe cmd
    " go back to link def
    :normal A
:endfunction


map <Leader>merm i<div class="mermaid"><CR>  graph LR<CR>     A[fa:fa-laptop <br> Client]-->| authenticate | M[fa:fa-server Master]<Esc><CR>^i</div><Esc>k^llllll


