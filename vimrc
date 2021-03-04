"General settings --- {{{
set t_Co=256
color jellybeans
syntax on
set nu
set smartindent 
set sw=4
set ts=4
set sts=4
set expandtab
set hlsearch
set splitright
set nocompatible
set incsearch
set laststatus=2
set cursorline
filetype off
filetype plugin indent on   
set completeopt=menu
set backspace=indent,eol,start
set tw=100
set colorcolumn=100
set wfh
set wfw
let g:go_version_warning = 0

" }}}

"Some autocmds --- {{{
augroup filetype_c 
    autocmd!
    autocmd FileType c,cpp setlocal foldmethod=manual
    autocmd FileType c,cpp noremap <buffer> <leader>c I//<esc>
    autocmd FileType c,cpp noremap <buffer> <leader>d ^xx
    "autocmd InsertLeave * if pumvisible()==0|pclose|endif
augroup END
augroup filetype_script 
    autocmd!
    autocmd FileType tcl,sh noremap <buffer> <leader>c I#<esc>
    autocmd FileType tcl,sh noremap <buffer> <leader>d ^x<esc>
augroup END
augroup filetype_xml
    autocmd!
    "autocmd BufWritePre *.html :normal gg=G
    autocmd FileType xml,html noremap <buffer> <leader>c I<!--><esc>A<--><esc>
    autocmd FileType xml,html noremap <buffer> <leader>d ^5x$3h4x
augroup END
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType .vim noremap <buffer> <leader>c I"<esc>
    autocmd FileType .vim noremap <buffer> <leader>d ^x<esc>
augroup END
augroup filetype_make
    autocmd!
    autocmd FileType make set noet
augroup END
augroup filetype_mkd
    autocmd!
    autocmd FileType mkd set tw=140
    autocmd FileType mkd set colorcolumn=140
augroup END
augroup filetype_go
    autocmd!
    autocmd FileType go NeoCompleteEnable
augroup END
augroup filetype_yaml
    autocmd!
    autocmd FileType yaml set sts=2
    autocmd FileType yaml set ts=2
    autocmd FileType yaml set sw=2
augroup END
augroup HightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('airline_warning', '\(TODO:\?\)', -1)
    autocmd WinEnter,VimEnter * :silent! call matchadd('DbgCurrent', '\(\(FIXME\)\|\(NOTE\)\):\?', -1)
augroup END
"}}}

"Some maps --- {{{
let mapleader=","
nnoremap tb :TagbarToggle<cr>
nnoremap <F12> : AV<cr>
nnoremap <leader>bf :buffers<cr>
nnoremap <silent> <F3> :Grep<CR>
"nnoremap <leader>F :/\v(^|:{2})start<cr>
"nnoremap <leader>F :/\v(^|:{2})Start<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>g :silent exe "grep! -r " . shellescape(expand("<cWORD>")) . " ."<cr>:copen 5<cr>
nnoremap <leader>pbr :execute "rightbelow vsplit " . bufname("#")<cr>
nnoremap <leader>pbl :execute "leftabove vsplit " . bufname("#")<cr>
nnoremap <leader>pba :execute "aboveleft split " . bufname("#")<cr>
nnoremap <leader>pbb :execute "belowright split " . bufname("#")<cr>
nnoremap <leader>bt :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr><cr>
nnoremap <leader>ast :set tags+=/ws/phye/stl/tags<cr>
nnoremap <F2> : set invpaste paste?<CR>
set pastetoggle=<F2>

inoremap jk <ESC>
"inoremap <ESC> <nop>
" }}}

"Some commands --- {{{
":ScratchBuffer makes current buffer disposable
command! ScratchBuffer setlocal buftype=nofile bufhidden=hide noswapfile
" }}}

"Some Abbreviations --- {{{
abbrev adn and
abbrev teh the
abbrev #i #include
abbrev #d #define
abbrev #p #!/usr/bin/perl
" }}}

"Plugin specific --- {{{

"pathogen related
call pathogen#infect()
"vundle related, vundle itself is not platform related ..
"set rtp+=~/.vim/bundle/
"call vundle#rc()
"Bundle 'gmarik/vundle'

"For SuperTab
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"For OmniCppComplete
let OmniCpp_MayCompleteDot=1
let OmniCpp_MayCompleteArrow=1
let OmniCpp_MayCompleteScope=1
let OmniCpp_SelectFirstItem=2
let OmniCpp_NamespaceSearch=2
let OmniCpp_ShowPrototypeInAbbr=1

"window manager related
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nnoremap wm :WMToggle<cr>

"cscope related
set cscopequickfix=s-,c-,d-,i-,t-,e-
set cspc=5

"vim-airline
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
"
"neocomplete related
let g:neocomplete#enable_at_startup=1
let g:neocomplete#sources#syntax#min_keyword_length = 3
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
"let g:neocomplete#sources#omni#functions.javascript = [
"            \ 'tern#Complete',
"            \ ]
"vim-easymotion
let g:EasyMotion_leader_key = '<Space>'

"emmet-vim
"let g:user_emmet_install_global = 0
"autocmd FileType html,css EmmetInstall
let g:user_emmet_mode='a'

"Powerful Unite!
nnoremap <C-p> :Unite file_rec/async<cr>

"delimitMate"
let delimitMate_expand_cr = 1

"fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>c :Commits<cr>
" }}}

"{{{ Misc functions
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
    if exists("s:maximize_session")
        exec "source " . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec "mksession! " . s:maximize_session
        only
    endif
endfunction
"}}}
