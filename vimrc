"required for bundle
set nocompatible            
filetype on                  
filetype off               
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"required for bundle
filetype plugin indent on   

Bundle 'gmarik/vundle'

"add for me
Bundle 'ctrlp.vim'
Bundle 'AutoClose'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'a.vim'
Bundle 'minibufexplorerpp'
Bundle 'c.vim'
Bundle 'Visual-Mark'
Bundle 'https://github.com/vim-scripts/cpp.vim--Skvirsky.git'
Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'https://github.com/Lokaltog/vim-easymotion.git'

"vimproc and unite are required by vimshell"
"vimproc must execute make to use it""
Bundle 'http://github.com/Shougo/vimproc'
Bundle 'https://github.com/Shougo/unite.vim'
Bundle 'https://github.com/Shougo/vimshell.vim.git'

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



let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"config for me
set shell=/bin/bash\ -i
set nocp
set nonu
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set hlsearch
syntax enable
set cindent
"class public private not use space
set cino=:g0
set nocompatible
syntax on
set backspace=indent,eol,start
set ruler
set hidden
set background=dark
set softtabstop=4
set incsearch
set wildmenu
set wildmode=longest:full,full


"代码折叠, 命令 za
set foldmethod=syntax
set foldlevel=100  "启动vim时不要自动折叠代码

set cst "when  c-] tag match more than one , let me select
set tags+=./tags
set tags+=~/.tags/self_add_tags_store/cpp_tags/tags
set tags+=~/.tags/self_add_tags_store/system_tags/tags
set tags+=~/gaia_offline/_external/usr/local/tags
set path+=./
set path+=~/.tags/self_add_tags_store/cpp_tags/cpp_src/
set path+=~/gaia_offline/_external/urs/local/include/

autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown

"use for auto-complete tags
filetype plugin indent on
set complete=.,w,b,u,t,i
set completeopt=longest,menu

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"when vim demo_project/demo_project , realsrcdir is demo_project/
function GetRealSrcDir()
    let l:pwd = printf("%s/%s", getcwd(), system("pwd | awk -F\"/\" '{print $NF}'"))
    let l:dir =  strpart(l:pwd, 0, strlen(l:pwd)-1)
    if isdirectory(l:dir)
        return l:dir
    else
        return getcwd()
endfunction

"set quickfix make and output msg format
function FunForQuickfix(makeprgIn, makeefmIn)
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

function CompileAndRunCurrentTestCodeByScons()
  call FunForQuickfix(printf("scons -u %s -j16", expand("%:p:h")), '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.')
endfunction

function CompileAndRunTestByScons()
  call FunForQuickfix("scons -u . -j16", '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.')
endfunction

function CompileByScons()
  call FunForQuickfix('scons -j16', '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.,%sError%m')
endfunction

function CppCheck()
  call FunForQuickfix(printf("cppcheck *.cpp --enable=all %s", GetRealSrcDir()), "\[%f:%l\]:\ %m")
endfunction

"highlight class member, like mRecord
"
autocmd BufWinEnter * match MoreMsg /\<m[A-Z]\w*/

command!BufCloseOthers call <SID>BufCloseOthers()
command!BufCloseRights call <SID>BufCloseRights()

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
"/home/adb/clean/clean/util/test/  return /home/adb/clean"
function GetProjectDir()
    let l:data = printf("%s", system(" pwd | awk 'BEGIN{ FS=\"/\";ORS=\"/\";} {for (i = 1; i <= NF; i++) {if ($i == $(i-1)) {x=i;}  }}END {for (j = 1; j < x; j++) { print $j }}'"))
    return l:data
endfunction
function CdPath(dirpath)
    execute("cd ".a:dirpath)
endfunction

"keep window position when switching buffers
if v:version >= 700
    au BufLeave * let b:winview = winsaveview()
    au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

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
" nmap <space> <C-D>
" easy head end
noremap H ^
noremap L $
nmap * *N
nmap mp "0p
nmap mP "0P

nmap ,w :w<cr>

"make so to insert new line and still in this line
nmap so o<ESC>k
nmap sO O<ESC>j

" Smart way to move between windows
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

nmap - <C-W>-
nmap + <C-W>+

"easy to swith cpp and h
nmap ,a :A<cr>


nmap mcd :call CdPath('%:p:h')<cr>
nmap mcr :call CdPath('%:p:h')<cr>:call CdPath(printf("%s", GetProjectDir()))<cr>

"compile use
nmap ma :wa<CR>:call CompileByScons()<CR>
nmap mu :wa<CR>:call CompileAndRunCurrentTestCodeByScons()<CR>
nmap mua :wa<CR>:call CompileAndRunTestByScons()<CR>
nmap mc :wa<CR>:call CppCheck()<CR>
map <F5> <ESC>ma<CR>
map <F6> <ESC>mu<CR>


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


imap <C-a> <Home>
imap <C-e> <End>
imap <C-k> <ESC>lld$i

imap <tab> <C-R>=SuperTab()<CR>
