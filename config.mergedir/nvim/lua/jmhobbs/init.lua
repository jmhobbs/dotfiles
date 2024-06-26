local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

-- Not vi compatible (obviously)
opt.compatible = false

-- Be Pretty!
cmd [[syntax on]]
cmd [[set termguicolors]]
g.vim_monokai_tasty_machine_tint = 1
g.vim_monokai_tasty_highlight_active_window = 1
cmd [[colorscheme vim-monokai-tasty]]
opt.background = "dark"

-- UTF-8 FTW!
opt.encoding = "utf-8"
--opt.termencoding = "utf-8"

-- Use a patched font
opt.guifont = "SauceCodePro NF:h14"

-- Tabs == 2 spaces
opt.tabstop = 2
opt.shiftwidth = 2

opt.smartindent = true        -- Try to be clever vim
opt.expandtab = true          -- Spaces, not tabs todo: editorconfig?
opt.incsearch = true          -- Incremental search
opt.ignorecase = true         -- Case-insensitive search by default
opt.smartcase = true          -- Case-sensitive search if uppcase is used
opt.wildmenu = true           -- Turn on tab completion menu
opt.wildmode = "list:longest" -- Make tab completion work like shell
opt.scrolloff = 3             -- Start scrolling viewport 3 lines ahead of cursor
opt.foldenable = false        -- No code folding
opt.number = true             -- Show line nunbers
opt.laststatus = 2            -- Status line on
opt.wrap = false              -- No line wrapping
opt.list = true               -- I like seeing invisible characters
opt.signcolumn = "yes"        -- Always keep the signs gutter present
opt.cursorline = true         -- Highlight the current line

-- opt.invisible characters
opt.listchars = "tab:-∙,trail:∙,precedes:«,extends:»"

-- Faster autocomplete with less searching
opt.complete:remove({ "i" })

-- Ignore these when globbing
opt.wildignore:append({ "*.pyc", "*.log", "*.otf", "*.woff" })

-- STFU Bells
opt.errorbells = false
opt.visualbell = false

cmd [[filetype plugin indent on]]

require("jmhobbs.mappings")
require("jmhobbs.plug")
require("jmhobbs.plugins")
