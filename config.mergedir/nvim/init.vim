set nocompatible

call plug#begin()

" Status Line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tree Browser
Plug 'ms-jpq/chadtree', { 'do': ':CHADdeps' }

" Close the buffer, leave the window
Plug 'vim-scripts/BufClose.vim'
Plug 'vim-scripts/BufOnly.vim'

" Fuzzy Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

" Editor Config
Plug 'editorconfig/editorconfig-vim'

" Diff markers in the gutter
Plug 'mhinz/vim-signify'

" Fuzzy finder
Plug 'junegunn/fzf.vim'

" LSP support
Plug 'neovim/nvim-lspconfig'

" Omnicomplete
Plug 'ms-jpq/coq_nvim', {'branch': 'coq', 'do': ':COQdeps'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" Dev icons support
Plug 'ryanoasis/vim-devicons'

call plug#end()

filetype plugin indent on

" Be Pretty!
set t_Co=256
set background=dark
colorscheme molokai

" UTF-8 FTW!
set encoding=utf-8
set termencoding=utf-8

" Keep backup/swap centrally
set backupdir=~/.vim/backup
set dir=~/.vim/backup
set noswapfile

" Use a patched font
set guifont=SauceCodePro\ NF:h14

" Tabs == 2 spaces
set tabstop=2
set shiftwidth=2

set smartindent             " Try to be clever vim
set expandtab               " Spaces, not tabs
syntax enable               " Syntax highlighting
set incsearch               " Incremental search
set ignorecase              " Case-insensitive search by default
set smartcase               " Case-sensitive search if uppcase is used
set wildmenu                " Turn on tab completion menu
set wildmode=list:longest   " Make tab completion work like shell
set scrolloff=3             " Start scrolling viewport 3 lines ahead of cursor
set nofoldenable            " No code folding
set number                  " Show line nunbers
set laststatus=2            " Status line on
set showmatch               " Show matching braces
set nowrap                  " No line wrapping
set list                    " I like seeing invisible characters

" Set invisible characters
set listchars=tab:-∙,trail:∙,precedes:«,extends:»

" Faster autocomplete with less searching
set complete-=i

" Ignore these when globbing
set wildignore+=*.pyc,*.log,*.otf,*.woff

" STFU Bells
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

"""""""""""""""""
" Misc Mappings "
"""""""""""""""""

" Change the leader
let mapleader = ","
let g:mapleader = ","

" =j indents as JSON
nmap =j :%!jq .<CR>

" Expand %% into the current directory of the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>

" Open/Close nvim-tree with control-n
nmap <silent> <c-n> :CHADopen<CR>

" leader+r executes file
nnoremap <leader>r :!%:p

"""""""""""""""""""
" / Misc Mappings "
"""""""""""""""""""


""""""""""""""""""""
" Buffer Shortcuts "
""""""""""""""""""""

" Next Buffer
nmap <leader>n :bn<cr>

" Previous Buffer
nmap <leader>p :bp<cr>

" Close Buffer but not split
nmap <leader>q :BufClose<cr>
nmap <silent> <c-d> :BufClose<CR>:bn<cr>

" Switch between current and last buffer
nmap <leader>. <c-^>
nmap <leader>, <c-^>

""""""""""""""""""""""
" / Buffer Shortcuts "
""""""""""""""""""""""


""""""""""""""""""""
" Window Shortcuts "
""""""""""""""""""""

" Resize vertical splits
map <silent> <C-l> <C-w><
map <silent> <C-h> <C-w>>

""""""""""""""""""""""
" / Window Shortcuts "
""""""""""""""""""""""


"""""""""""
" signify "
"""""""""""

let g:signify_vcs_list     = ['git']
let g:signify_sign_change  = '±'

"""""""""""""
" / signify "
"""""""""""""

"""""""""""""
"  Airline  "
"""""""""""""
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_powerline_fonts=1

let g:airline_theme="papercolor"

"""""""""""""
" Telescope "
"""""""""""""
nmap <silent> <c-p> :Telescope find_files<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

""""""""""""
" CHADTree "
""""""""""""
lua <<EOF
vim.g.chadtree_settings = {
  theme = {
    -- Colors for the drawer
    text_colour_set = 'solarized_dark',
  }
}
EOF


""""""""""""""""""""
" coq + lsp-config "
""""""""""""""""""""

lua <<EOF
local lspconfig = require('lspconfig')

-- Automatically start coq
vim.g.coq_settings = { auto_start = 'shut-up' }

local servers = { 'gopls' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
  }))
end
EOF
