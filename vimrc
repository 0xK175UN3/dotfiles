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
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'

"Languages support
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'

"Editor features
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'valloric/youcompleteme'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'

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

"Color theme settings
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 234
colo seoul256

" ====================================
" mappings
" ====================================
map <C-n> :NERDTreeToggle<CR>
