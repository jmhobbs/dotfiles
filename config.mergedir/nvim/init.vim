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

" Go
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSInstallSync go' }
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

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
set signcolumn=yes          " Always keep the signs gutter present

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

""""""""""
" go.vim "
""""""""""
lua <<EOF
-- Run gofmt on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup({
  lsp_inlay_hints = {
    only_current_line = false
  }
})
EOF


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
-- Automatically start coq
vim.g.coq_settings = { auto_start = 'shut-up' }

local lspconfig = require('lspconfig')
local coq = require('coq')

-- Setup LSP and attach coq
local servers = { 'gopls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
  }))
end


-- Add some bindings for lsp
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

EOF
