" Sample .vimrc file by Martin Brochhaus
"
"
" after	:setlocal spell spelllang=en_us zg requires this, otherwise use zG:
set spellfile=~/.config/nvim/spell/en.utf-8.add

call plug#begin()
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'cocopon/iceberg.vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'jdkanani/vim-material-theme'
Plug 'shime/vim-livedown'
"Plug 'vim-scripts/autolink'
Plug 'sampsyo/autolink.vim'
"Plug 'mattn/webapi-vim'
"Plug 'christoomey/vim-quicklink'

"Plug 'mattn/webapi-vim'
"Plug 'christoomey/vim-quicklink'
call plug#end()

set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'gg/tabular'
call vundle#end()            " required
filetype plugin indent on    " required

" Sample .vimrc file by Martin Brochhaus
" 
iab Pdb import pdb; pdb.set_trace()
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
set textwidth=80
set wrapmargin=2

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
"set clipboard=unnamed

" Mouse and backspace
set mouse=r  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

set ml
" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quick quit command
noremap <Leader>q :quit!<CR>  " Quit current window
noremap <Leader>Q :qa!<CR>   " Quit all windows
" done, save quit:
noremap <Leader>d :wq!<CR>   " Save quit, d=done
noremap <Leader>w :w!<CR>:set nofoldenable<CR>    " Save
noremap <Leader>f :set nofoldenable<CR>    " Unfold everything

set foldnestmax=10
set foldmethod=syntax
set nofoldenable
set foldlevel=5

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=59

hi Search cterm=NONE ctermfg=black ctermbg=yellow

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
"" set nobackup
"" set nowritebackup
"" set noswapfile




" ============================================================================
" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2


" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 80
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" disable arrow keys - need to have hjkl in muscle memory:
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>
" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
map <Leader>g :call RopeGotoDefinition()<CR>
let g:pymode_lint_checker = 'pyflakes'
"map <Leader>b Oimport pdb; pdb.set_trace()<C-c>
"map <Leader>b Odebugger<C-c>
map <Leader>b Oimport pdb; pdb.set_trace()<C-c>
"map <Leader>e try:<CR><TAB><C-c>except Exception as ex:<CR>import pdb;pdb.set_trace()<C-c>
"map <Leader>e Otry:<Esc>j^i<TAB><CR>iexcept Exception as ex:<CR>import pdb;pdb.set_trace()<CR><Esc><jkllll
map <Leader>e Otry:<Esc>j^i<TAB><Esc>oexcept Exception as ex:<CR>import pdb;pdb.set_trace()<Esc>^
map <Leader>ts :Tabularize/(<CR><bar>:Tabularize/)<CR><bar>:Tabularize/:<CR>
map <Leader>t\| :Tabularize/\|<CR>

" missing the z key, this collapses and opens all syntax folds:
map <Leader>mf zM<CR>
map <Leader>mr zR<CR>


" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

autocmd Syntax * call matchadd('Todo',  '\W\zs\(NOTE\|TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
" close the quickfix window if its the last open window:
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END



" Quick quit command    
noremap <Leader>q :quit!<CR>  " Quit current window    
noremap <Leader>Q :qa!<CR>   " Quit all windows    
" " done, save quit:    
noremap <Leader>d :wq!<CR>   " Save quit, d=done    
noremap <Leader>w :w!<CR>:set nofoldenable<CR>    " Save    
noremap <Leader>f :set nofoldenable<CR>    " Unfold everything    
"     
"     " hit ,h on a python definition and you are in the file. Strg-o gets u
"     back:  
"let g:jedi#goto_command = "<leader>h"    

set foldmethod=syntax

autocmd FilterWritePre * if &diff | set wrap linebreak nolist | endif
au BufReadPost *.md set syntax=markdown
set foldcolumn=2

