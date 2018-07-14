" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/syntastic' #YCM instead
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdcommenter'


" Initialize plugin system
call plug#end()


set mouse=a
set number


map <C-n> :NERDTreeToggle<CR>

""" NERDCommenter Settings

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Recommended syntastic settings
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1 
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g_syntasitc_check_on_wq = 0


" YouCompleteMe settings
" python support
let g:ycm_python_binary_path = 'python'

" Solarized colors
syntax enable
"set t_Co=256
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized

set nosmarttab
set shiftwidth=2
set expandtab
set softtabstop=2
set shiftround
set autoindent

set colorcolumn=80
