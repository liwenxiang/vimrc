syntax on
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'a.vim'
Plugin 'https://github.com/tomtom/tcomment_vim.git'
Plugin 'https://github.com/airblade/vim-rooter.git'
Plugin 'https://github.com/ap/vim-buftabline.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/ervandew/supertab.git'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'https://github.com/tpope/vim-dispatch.git'
Plugin 'https://github.com/vim-scripts/cpp.vim--Skvirsky.git'

call vundle#end()            " required
filetype plugin indent on    " required

let g:rooter_patterns = ['SConstruct', '.git/']
let g:dispatch_handlers = ['tmux']

if &diff == 'nodiff'
    set shellcmdflag=-ic
endif
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

let g:save_make_input="scons -j36 "
function! InputForCompile()
    try
        call inputsave()
        let l:save_makeprg=&makeprg
        " let l:make = printf("%s %s",g:save_make_input, expand("%:p:h"))
        " let g:save_make_input=input("Compile:  ", l:make, "customlist,MyFileComplete")
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
    ":make
    :Make
    :cw
  finally
    let &makeprg=save_makeprg
    let &efm=save_makeefm
  endtry
endfunction

function! CompileAndRunCurrentTestCodeByScons()
  call FunForQuickfix(printf("scons -u %s -j36", expand("%:p:h")), '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.')
endfunction

function! CompileAndRunTestByScons()
  call FunForQuickfix("scons -u . -j36", '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.')
endfunction

function! CompileByScons()
  call FunForQuickfix('scons -j36', '%f:%l:%c:\ %m,%f:%l:\ %m,build/release64/%f:%l:%c:\ %m,build/release64/%f:%l:\ %m,%f\|%l\|,build/release64/%f:%s,%m:%l:Assertion,%sExpression:\ false,scons:\ building\ terminated\ because\ of\ errors.,%sError%m')
endfunction

autocmd BufWinEnter * match MoreMsg /\<m[A-Z]\w*/

command!BufCloseOthers call <SID>BufCloseOthers()
command!BufCloseRights call <SID>BufCloseRights()
command!InsertHeader call <SID>InsertHeader()

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
