syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test'
Plug 'epmatsw/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kassio/neoterm'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

colorscheme molokai
let g:airline_theme='simple'

set tabstop=2 shiftwidth=2 expandtab
set nu

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" search with Ag
noremap <leader>a :Ag!<space>

" highlight color
hi Search ctermbg=DarkMagenta ctermfg=Magenta

" relative line-numbering
set relativenumber

" leader
let mapleader=","

" remove highlight
map <leader>h :noh<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-test mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" no swap files
set noswapfile

" mouse
if has('mouse')
  set mouse=a
endif

" neoterm
map <C-t> :Ttoggle<CR>
tnoremap <ESC> <C-\><C-n>
tnoremap <C-t> <C-\><C-n>:Ttoggle<CR>
let g:neoterm_autoinsert = 1
let g:neoterm_default_mod = "botright"

" misc
set splitright
set splitbelow
