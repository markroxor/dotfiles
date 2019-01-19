set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""""VUNDLE""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-conflicted'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'scrooloose/nerdtree'
Plugin 'nvie/vim-flake8'
Plugin 'Nequo/vim-allomancer'
Plugin 'mkitt/tabline.vim'
" Plugin 'JamshedVesuna/vim-markdown-preview'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" source ~/.vim_runtime/vimrcs/plugins_config.vim
Plugin 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:ycm_show_diagnostics_ui = 1

" VIM coding scheme
colo mysticaltutor

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set shell=/bin/bash
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set directory=~/.vim/tmp

set wrap mouse=a
set dir=~/.vim/tmp backupdir=~/.vim/tmp
set ignorecase smartcase shiftround smartindent
set t_Co=256
set autochdir

filetype plugin indent on

runtime macros.vim

" Fix Python indentation.
autocmd FileType python setlocal shiftwidth=4 tabstop=4

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Don't remap '#' to avoid smartindent problem
:inoremap # X<BS>#

" Spelling.
function! ToggleSpell()
  if !exists("b:spell")
    setlocal spell spelllang=en_us
    let b:spell = 1
  else
    setlocal nospell
    unlet b:spell
  endif
endfunction

" Key mappings.
nmap <F4> :call ToggleSpell()<CR>
imap <F4> <Esc>:call ToggleSpell()<CR>
nmap <F6> :w<CR>:!make<CR>
nmap <F8> :source ~/.vim/pdf-replace.vim<CR>
nmap <F9> <Esc>:%!fold -w 120<CR>i

" Commands.
" <leader>: \ (a backslash)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
 command Rm :call delete(expand('%')) | bdelete!

" Use LaTeX rather than plain TeX.
let g:tex_flavor = "latex"

set guioptions-=T  "remove menu bar

autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

" Save pointer location between sessions.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" autofire nerdtree
autocmd vimenter * NERDTree
let g:NERDTreeWinPos = "left"



set scrolloff=5
map <C-a> <esc>ggVG<CR>

" cursor for insert and normal mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" cursor shape in insert and normal modes
if has("autocmd")
      au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
        au InsertEnter,InsertChange *
            \ if v:insertmode == 'i' | 
            \   silent execute '!echo -ne "\e[5 q"' | redraw! |
            \ elseif v:insertmode == 'r' |
            \   silent execute '!echo -ne "\e[3 q"' | redraw! |
            \ endif
          au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
      endif

"TABS are 4 spaces long
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

" paste using F10
set pastetoggle=<F10>

" disabe autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

imap <Tab> <C-P>

" for showing line-number
set number

" left arrow key to prev line
set whichwrap+=<,>,[,]

" open NERDTree in all the tabs
autocmd BufWinEnter * NERDTreeMirror
syntax on
