"required for bundle
set nocompatible            
filetype on                  
filetype off               
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"add for me
""Bundle 'ctrlp.vim'
"Bundle 'AutoClose'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'a.vim'
Bundle 'https://github.com/fholgado/minibufexpl.vim.git'
Bundle 'Visual-Mark'
Bundle 'https://github.com/vim-scripts/cpp.vim--Skvirsky.git'
Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'https://github.com/Lokaltog/vim-easymotion.git'
Bundle 'https://github.com/majutsushi/tagbar.git'
"vimproc and unite are required by vimshell"
"vimproc must execute make to use it""
Bundle 'http://github.com/Shougo/vimproc'
Bundle 'https://github.com/Shougo/unite.vim'
Bundle 'https://github.com/liwenxiang/vimshell.vim.git'
Bundle 'https://github.com/Shougo/neocomplcache.vim.git'
Bundle 'https://github.com/liwenxiang/vim-rooter.git'
Bundle 'https://github.com/altercation/vim-colors-solarized.git'

Bundle "https://github.com/vim-scripts/undotree.vim.git"

Bundle 'https://github.com/vim-scripts/EasyGrep.git'
"Bundle 'https://github.com/Valloric/YouCompleteMe.git'
"Bundle 'https://github.com/scrooloose/syntastic.git'

"vimim use , remove all file in bundle/vimim/plugin but vimim.vim, that vimim
"will use baidu or sogou cloud to support input
"while input , use Ctrl-Shift-_ to get chinese input
Bundle 'https://github.com/vimim/vimim.git'
Bundle 'https://github.com/vim-scripts/Pydiction.git'
"use :Tag /|
Bundle 'https://github.com/godlygeek/tabular.git'
Bundle 'https://github.com/vim-scripts/vcscommand.vim.git'
Bundle 'https://github.com/tomtom/tcomment_vim.git'

Bundle 'https://github.com/vim-scripts/SearchComplete.git'
Bundle 'https://github.com/mbbill/echofunc.git'

Bundle 'https://github.com/terryma/vim-expand-region.git'
Bundle 'https://github.com/octol/vim-cpp-enhanced-highlight.git'
Bundle 'https://github.com/Shougo/unite.vim.git'

let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    Bundle 'clang-complete'
    let g:clang_auto_select=1
    let g:clang_complete_copen=1
    nmap mq <esc>:call g:ClangUpdateQuickFix()<cr>
else
    Bundle 'https://github.com/vim-scripts/OmniCppComplete.git'
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    let OmniCpp_MayCompleteScope = 0 " not autocomplete with ::
    let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
    let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
    let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
    let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
    let OmniCpp_MayCompleteArray=0 "mkae -> not appear
    let OmniCpp_DefaultNamespaces=["std"]
    let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the last column
    let OmniCpp_ShowAccess=1
endif

"required for bundle
filetype plugin indent on   

"==============tagbar=============="
nmap <C-o> :TagbarToggle<cr>
"==============ctrl-p=============="
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


"==============neocomplcache=============="
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'


"==============neocomplcache=============="
""In iTerm2, in Preferences -> Profiles -> Terminal, under "Terminal Emulation" you have "Report Terminal Type:" set to xterm-256color
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
syntax enable
set background=dark
colorscheme solarized


let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

"==============UndoTree=============="
if has("persistent_undo")
    set undodir = "~/.vim/undo_tmp/"
    set undofile
endif


"config for me
set shell=/bin/bash\ -i
set nocp
set nonu
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set hlsearch
set cindent
"class public private not use space
set cino=:g0
set backspace=indent,eol,start
set ruler
set hidden
set softtabstop=4
set incsearch
set wildmenu
set wildmode=longest:full,full
au InsertLeave * set nopaste
set showcmd
set showmode


"代码折叠, 命令 za
set foldmethod=syntax
set foldlevel=100  "启动vim时不要自动折叠代码


autocmd BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown

"use for auto-complete tags
filetype plugin indent on
set complete=.,w,b,u,t,i
set completeopt=longest,menu

set csto=1
set cst "when  c-] tag match more than one , let me select
set tags=tags,~/.tags/self_add_tags_store/cpp_tags/tags,~/gaia_offline/_external/usr/local/include/tags
"cpp tags use http://www.vim.org/scripts/script.php?script_id=2358
"or http://vim.wendal.net/scripts/script.php?script_id=2358

"set quickfix make and output msg format
function! FunForQuickfix(makeprgIn, makeefmIn)
  try
    let save_makeprg=&makeprg
    let save_makeefm=&efm
    let &makeprg=a:makeprgIn
    let &efm=a:makeefmIn
    :wa
    :make
    :cw
  finally
    let &makeprg=save_makeprg
    let &efm=save_makeefm
  endtry
endfunction

function! CompileAndRunCurrentTestCodeByScons()
  call FunForQuickfix(printf("scons -u %s -j16", expand("%:p:h")), '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.')
endfunction

function! CompileAndRunTestByScons()
  call FunForQuickfix("scons -u . -j16", '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.')
endfunction

function! CompileByScons()
  call FunForQuickfix('scons -j16', '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.,%sError%m')
endfunction

function! CppCheck()
  call FunForQuickfix(printf("cppcheck *.cpp --enable=all .", ), "\[%f:%l\]:\ %m")
endfunction

"highlight class member, like mRecord
"
autocmd BufWinEnter * match MoreMsg /\<m[A-Z]\w*/

command!BufCloseOthers call <SID>BufCloseOthers()
command!BufCloseRights call <SID>BufCloseRights()
command!Diff call <SID>DiffFunc()

function! <SID>DiffFunc()
    execute("VCSDiff")
endfunction

function! <SID>BufCloseOthers()
    let l:currentBufNum   = bufnr("%")
    for i in range(1,bufnr("$"))
        if buflisted(i)
            if i!=l:currentBufNum
                execute("bdelete ".i)
            endif
        endif
    endfor
endfunction
function! <SID>BufCloseRights()
    let l:currentBufNum   = bufnr("%")
    for i in range(l:currentBufNum+1,bufnr("$"))
        if buflisted(i)
            if i!=l:currentBufNum
                execute("bdelete ".i)
            endif
        endif
    endfor
endfunction


"keep window position when switching buffers
au BufLeave * let b:winview = winsaveview()
au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\s\?$')
        echo strpart(getline('.'),col('.')-2,1)
        return "\<Tab>"
    else
        echo strpart(getline('.'),col('.')-2,1)
        return "\<C-n>"
    endif
endfunction

" ****************** SCROLLING *********************  
set scrolloff=8         " Number of lines from vertical edge to start  scrolling
set sidescrolloff=15 " Number of cols from horizontal edge to start scrolling
set sidescroll=1       " Number of cols to scroll at a time


"runtime syntax/colortest.vim to test other color
highlight Pmenu ctermfg=black ctermbg=lightgreen
"key map
nmap j gj
nmap k gk
noremap H ^
noremap L $
nmap * *N
nmap mp "0p
nmap mP "0P

nmap ,w :w<cr>


nmap - <C-W>-
nmap + <C-W>+

"easy to swith cpp and h
nmap ,a :A<cr>


"compile use
nmap ma :wa<CR>:call CompileByScons()<CR>
nmap mu :wa<CR>:call CompileAndRunCurrentTestCodeByScons()<CR>
nmap mua :wa<CR>:call CompileAndRunTestByScons()<CR>
nmap mc :wa<CR>:call CppCheck()<CR>

nmap <F6> <ESC>mu<CR>

nmap <F5> <ESC>:!make_tags<cr><cr>

"quick fix use
nmap <F3> :cp<cr>
nmap <F4> :cn<cr>
"bufer use
nmap <S-J> :bp<cr>
nmap <S-K> :bn<cr>
nmap <C-X> :bd<cr>
"J use for :bp,so use M to combine two lines
noremap M J

"FufFind use
nmap mf :FufFileWithCurrentBufferDir<CR>
nmap mb :FufBuffer<CR>
""nmap <leader><leader> :b#<cr>
nmap ff :NERDTreeToggle<RETURN>


cmap <C-a> <Home>
cmap <C-e> <End>

imap <C-a> <Home>
imap <C-e> <End>
imap <C-k> <ESC>lld$i

imap <tab> <C-R>=SuperTab()<CR>
