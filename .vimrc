syntax on

set relativenumber
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

if executable('rg')
	let g:rg_derive_root='true'
endif

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'
Plug 'joshdick/onedark.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'davidhalter/jedi-vim'
Plug 'vim-airline/vim-airline'
call plug#end()
let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :NERDTreeToggle<CR>
nnoremap <leader>+ :vertical resize +5
nnoremap <leader>- :vertical resize -5

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt

colorscheme onedark

let g:carbon_now_sh_browser = 'chromiumbrowser'

let g:airline_powerline_fonts = 1
let g:airline_inactive_alt_sep = 0
let g:airline_focuslost_inactive = 0


let g:airline_section_b = '%{getcwd()}/%t'
let g:airline_section_c = ' ' "Not empty because of compatibility issues
let g:airline_section_y = ''
let g:airline_section_z = 'Line %l/%L'
let g:airline_skip_empty_sections = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#whitespace#enabled = 1

let g:jedi#popup_on_dot = 0

function! CarbonaraSC(firstLine, secondLine)
	%s/\t/    /g
	%s/\\/\\\\/g	"Escape escapes
	%s/\"/\\\"/g	"Escape double quotes
	%s/'/\'\\''/g	"Escape single quotes in a weird way
	%s/%/\\\%/g		"Escape g
	%s/%/\\%/g
	exe ''.a:firstLine.','.a:secondLine.'s/\n/\\n/g'
	norm I"
	norm A"
	norm $v^
	exe a:firstLine.'w! %:p:h/temp.carbonara'
	execute '!python3 /home/samore/carbonara/parer.py ' expand('%:p:h:').'/temp.carbonara'
	!rm %:p:h/temp.carbonara
	redr!
	u
endfunction
