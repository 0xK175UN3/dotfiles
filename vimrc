" ====================================
"          .vimrc of lainkun
" ====================================
" ====================================
"               plugins
" ====================================
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
" ====================================
"                common
" ====================================
"Browsing
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" ===================================
"          Languages support
" ===================================
"Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'bbatsov/rubocop'
"Javascript
Plug 'pangloss/vim-javascript'
"Editor features
Plug 'scrooloose/syntastic'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

"Color scheme
Plug 'junegunn/seoul256.vim'

call plug#end()

" ====================================
"           basic settings
" ====================================
set number
set showcmd
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set hidden
set expandtab
set tabstop=2
set shiftwidth=2
set scrolloff=5
set nocursorline
set autoread
set nu
set visualbell
set encoding=utf-8
set list
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
nmap ga <Plug>(EasyAlign)
let mapleader      = ' '
let maplocalleader = ' '
vnoremap <C-c> "*y
nmap <C-p> :FZF<CR>
