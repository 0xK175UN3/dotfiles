" ====================================
"          .vimrc of lainkun
" ====================================
" ====================================
"               plugins
" ====================================
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

"Browsing
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-easy-align'

"Color scheme
Plug 'junegunn/seoul256.vim'

call plug#end()

" ====================================
"           basic settings
" ====================================

set number
set expandtab
set tabstop=2
set hlsearch
set incsearch
syntax on
colo seoul256

" ====================================
" mappings
" ====================================
map <,-,> :NERDTreeToggle<CR>
