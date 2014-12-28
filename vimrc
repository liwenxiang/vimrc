"required for bundle
set nocompatible            
filetype on                  
filetype off               
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'a.vim'
Bundle 'https://github.com/vim-scripts/cpp.vim--Skvirsky.git'
Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'https://github.com/majutsushi/tagbar.git'
Bundle 'https://github.com/Shougo/neocomplcache.vim.git'
Bundle 'https://github.com/liwenxiang/vim-rooter.git'
Bundle 'https://github.com/altercation/vim-colors-solarized.git'
Bundle 'https://github.com/haya14busa/incsearch.vim.git'
Bundle 'https://github.com/ap/vim-buftabline.git'
Bundle 'https://github.com/tomtom/tcomment_vim.git'
Bundle 'https://github.com/MattesGroeger/vim-bookmarks.git'


let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    Bundle 'clang-complete'
    let g:clang_auto_select=1
    let g:clang_complete_copen=1
    nmap mq <esc>:call g:ClangUpdateQuickFix()<cr>
endif

"required for bundle
filetype plugin indent on   

" for incsearch plugin
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:vim_markdown_folding_disabled = 0

"==============tagbar=============="
nmap <C-o> :TagbarToggle<cr>
" 

""In iTerm2, in Preferences -> Profiles -> Terminal, under "Terminal Emulation" you have "Report Terminal Type:" set to xterm-256color
"set t_Co=256
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
syntax enable
set background=dark
"colorscheme solarized


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
set complete=.,w,b,u
set completeopt=longest,menu

set csto=1
set cst "when  c-] tag match more than one , let me select
set tags=tags,~/.tags/self_add_tags_store/cpp_tags/tags,~/gaia_offline/_external/usr/local/include/tags
"cpp tags use http://www.vim.org/scripts/script.php?script_id=2358
"or http://vim.wendal.net/scripts/script.php?script_id=2358

let g:save_make_input="blade build "
function! InputForCompile()
    try
        call inputsave()
        let l:save_makeprg=&makeprg
        " let l:make = printf("%s %s",g:save_make_input, expand("%:p:h"))
        "let g:save_make_input=input("Compile:  ", l:make, "customlist,MyFileComplete")
        let g:save_make_input=input("Compile:  ", g:save_make_input)
        execute ":redraw!"
        let &makeprg=g:save_make_input
        :make
    finally
        let &makeprg=l:save_makeprg
        call inputrestore()
    endtry
endfunction
command! Compile call InputForCompile()

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

cmap <C-a> <Home>
cmap <C-e> <End>

imap <tab> <C-R>=SuperTab()<CR>
