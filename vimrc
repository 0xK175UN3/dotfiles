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
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

"Languages support
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'

"Editor features
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
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
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'

"Color scheme
Plug 'junegunn/seoul256.vim'

call plug#end()

" ====================================
"           basic settings
" ====================================
set number
set linebreak	
set showbreak=+++	
set completeopt=menuone,preview
set encoding=utf-8
set nu
set showcmd
set visualbell
set textwidth=100	
set showmatch	
set visualbell
 
set hlsearch	
set smartcase	
set ignorecase
set incsearch	
 
set expandtab	
set shiftwidth=2
set smartindent	
set smarttab
set softtabstop=2	
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
