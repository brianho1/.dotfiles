" starting vimrc
" @brianho
syntax on
set nocompatible
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors 
set number
set relativenumber
set autoindent
set mouse=a

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'davidhalter/jedi-vim'    
  Plug 'sheerun/vim-polyglot'
  Plug 'ghifarit53/tokyonight-vim'
call plug#end()

" for plug in to load correctly
filetype plugin indent on

colorscheme tokyonight

let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1
"let g:tokyonight_transparent_background = 1

" extra config
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
map <leader>sv :source ~/.vimrc<CR>

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





