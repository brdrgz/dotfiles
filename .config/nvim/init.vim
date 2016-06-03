syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'epmatsw/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

colorscheme molokai
let g:airline_theme='simple'

set tabstop=2 shiftwidth=2 expandtab
set clipboard+=unnamedplus
set nu

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" search with Ag
noremap <leader>a :Ag<space>
