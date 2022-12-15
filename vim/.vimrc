" starting vimrc
" @brianho
syntax on
" for plug in to load correctly
filetype plugin indent on
set background=dark
set nocompatible
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set autoindent
set mouse=a

" make italic comment possible 
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'davidhalter/jedi-vim'    
  Plug 'sheerun/vim-polyglot'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
call plug#end()

"color scheme config
set t_Co=256
set cursorline
colorscheme onehalfdark 
let g:airline_theme='onehalfdark'

"True Colors
"By default vim only allows specifying one of the 256 (8 bit) predefined colors (wikipedia).
"If you want to match colors in vim and in your terminal exactly, you must enable true colors (24 bit).
"In vim/neovim, use set termguicolors option:


if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" remap leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" move between windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" move panes
noremap <C-w>1 <C-W>J
noremap <C-w>2 <C-W>K
noremap <C-w>3 <C-W>H
noremap <C-w>4 <C-W>L

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" quickly insert parenthesis/brackets in insert mode
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i


vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>



"map key to nerdtree
map <leader>nn :NERDTreeToggle<CR>
"source vim
map <leader>sv :source %<CR>

"managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
"map copy and paste
" copy all and move cursor back to original palce
map <leader>ya ggVGy<C-O><C-O> 
" paste from clipboard
map <leader>cp "*p
" copy to clipboard in visual mode
" Note: in MAC and WINDOWS * and + register are no difference.
vnoremap <leader>cy "*y

