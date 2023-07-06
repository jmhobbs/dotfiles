local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Mason for installing tools
Plug('williamboman/mason.nvim', { ['do'] = ':MasonUpdate' })
Plug 'williamboman/mason-lspconfig.nvim'

-- Dev icons support
-- Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'

-- Trouble Panel
Plug 'folke/trouble.nvim'

-- LSP support
Plug 'neovim/nvim-lspconfig'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSInstallSync go' })
Plug 'ray-x/lsp_signature.nvim'

-- Status Line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- Tree Browser
Plug('ms-jpq/chadtree', { ['do'] = ':CHADdeps' })

-- Close the buffer, leave the window
Plug 'vim-scripts/BufClose.vim'
Plug 'vim-scripts/BufOnly.vim'

-- Fuzzy Finder
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { branch = '0.1.x' })

-- Editor Config
Plug 'editorconfig/editorconfig-vim'

-- Diff markers in the gutter
Plug 'mhinz/vim-signify'

-- Autocomplete
Plug('ms-jpq/coq_nvim', { branch = 'coq', ['do'] = ':COQdeps'})
Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' })
Plug('ms-jpq/coq.thirdparty', { branch = '3p' })

-- Go
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

-- Copilot
Plug 'github/copilot.vim'

-- Indent Guides
Plug 'lukas-reineke/indent-blankline.nvim'

vim.call('plug#end')
