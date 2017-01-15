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
augroup nerd_loader
          autocmd!
            autocmd VimEnter * silent! autocmd! FileExplorer
              autocmd BufEnter,BufNew *
                      \  if isdirectory(expand('<amatch>'))
                      \|   call plug#load('nerdtree')
                      \|   execute 'autocmd! nerd_loader'
                      \| endif
      augroup END

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
