set shell=/bin/bash
set nocompatible

set shiftwidth=4 tabstop=4 expandtab
set wrap mouse=a
set dir=~/.vim/tmp backupdir=~/.vim/tmp
set ignorecase smartcase shiftround smartindent
set t_Co=256
set autochdir

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
runtime vundle.vim
execute pathogen#infect()

set background=dark
try
	colorscheme mark
catch /^Vim\%((\a\+)\)\=:E185/
  " Don't load a color scheme.
endtry
filetype plugin indent on

runtime macros.vim

" Fix Python indentation.
autocmd FileType python setlocal shiftwidth=2 tabstop=2

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

" Folding.
" set foldmethod=manual
" inoremap <F9> <C-O>za
" nnoremap <F9> za
" onoremap <F9> <C-C>za
" vnoremap <F9> zf

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

" Dvorak.
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
" noremap k n
" noremap K N
" noremap h <left>
" noremap t <down>
" noremap n <up>
" noremap s <right>
"

" source ~/.vim_runtime/vimrcs/plugins_config.vim
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:ycm_show_diagnostics_ui = 1
  Plugin 'scrooloose/syntastic'

set scrolloff=5
map <C-a> <esc>ggVG<CR>

" cursor for insert and normal mode
autocmd InsertEnter,InsertLeave * set cul!

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

call pathogen#helptags()

imap <Tab> <C-P>
" Plugin 'JamshedVesuna/vim-markdown-preview'

" for showing line-number
set number

" left arrow key to prev line
set whichwrap+=<,>,[,]

autocmd BufWinEnter * NERDTreeMirror
