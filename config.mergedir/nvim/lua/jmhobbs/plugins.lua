----------------------------------------------------------------------------
-- Dev Icons
----------------------------------------------------------------------------
require('nvim-web-devicons').setup({
  color_icons = true,
  default = true,
  strict = true,
})

----------------------------------------------------------------------------
-- Indentation Guides
----------------------------------------------------------------------------

local iblHooks = require("ibl.hooks")
iblHooks.register(iblHooks.type.HIGHLIGHT_SETUP, function() 
  vim.api.nvim_set_hl(0, "IndentBlanklineIndentHighlight", { fg = "#444444" })
end)
require("ibl").setup({
  scope = {
    highlight = "IndentBlanklineIndentHighlight",
    char = "▎",
    show_start = false,
    show_end = false,
  },
})

----------------------------------------------------------------------------
-- Todo Highlights
----------------------------------------------------------------------------

require("todo-comments").setup({
  keywords = {
    FIX = {
      icon = " ",
      color = "error",
      alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" },
    },
    TODO = {
      icon = " ",
      color = "info",
      alt = { "TODO", "TASK" },
    },
    HACK = {
      icon = " ",
      color = "warning",
      alt = { "HACK", "WIP" },
    },
    WARN = {
      icon = " ",
      color = "warning",
      alt = { "WARNING", "XXX" },
    },
    PERF = {
      icon = " ",
      color = "warning",
      alt = { "OPTIM", "PERF", "OPTIMIZE" },
    },
    NOTE = {
      icon = " ",
      color = "hint",
      alt = { "NOTE", "INFO" },
    },
  },
})

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

----------------------------------------------------------------------------
-- Trouble : Pretty diagnostics view
----------------------------------------------------------------------------
require('trouble').setup({
  mode = "document_diagnostics",
  auto_preview = false,
  action_keys = {
    open_folds = {"zO", "zo"},
    close_folds = {"zC", "zc"},
  },
})

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<space>q", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})

----------------------------------------------------------------------------
-- mason / mason-lspconfig : download and install tooling
----------------------------------------------------------------------------

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "eslint",
    "gopls",
    "phpactor",
    "terraformls",
    "tsserver",
    "zls",
  }
})

----------------------------------------------------------------------------
-- signify : git status in a gutter
----------------------------------------------------------------------------

vim.g.signify_vcs_list = { 'git' }
vim.g.signify_sign_change = '±'

----------------------------------------------------------------------------
-- airline : fancy bottom status bar
----------------------------------------------------------------------------

vim.g.Powerline_symbols = 'fancy'
vim.cmd([[set fillchars+=stl:\ ,stlnc:\]])
-- vim.opt.fillchars:append({ stl = " ", stlnc = ": " })

if vim.g.airline_symbols == nil then
  vim.g.airline_symbols = {}
end

vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''
vim.g.airline_symbols = {
  branch = '',
  readonly = '',
  linenr = '',
}
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'monokai_tasty'

----------------------------------------------------------------------------
-- Telescope : quick find buffers, files, etc.
----------------------------------------------------------------------------

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  pickers = {
    lsp_references = {
      theme = "cursor",
      trim_text = true,
      shorten_path = true,
      layout_config = {
        width = 0.6,
        preview_width = 0.4,
        preview_cutoff = 160,
      },
    },
    live_grep = {
      theme = 'ivy',
      layout_config = {
        height = 40,
      },
    },
    find_files = {
      theme = 'ivy',
      layout_config = {
        height = 40,
      },
    },
    buffers = {
      theme = 'ivy',
      layout_config = {
        height = 40,
      },
    },
    help_tags = {
      theme = 'ivy',
      layout_config = {
        height = 40,
      },
    },
  }
}

vim.keymap.set("n", "<c-p>", "<cmd>Telescope find_files<cr>", { silent = true })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { noremap = true })

----------------------------------------------------------------------------
-- go.vim : helpers for writing Go
----------------------------------------------------------------------------
-- todo: do I still need/want this plugin?

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

----------------------------------------------------------------------------
-- CHADTree : tree nav sidebar
----------------------------------------------------------------------------

vim.g.chadtree_settings = {
  options = {
    -- Hidden items visible by default
    show_hidden = true,
  },
  theme = {
    -- Colors for the drawer
    text_colour_set = 'solarized_dark',
  },
}

-- Open/Close tree with control-n
vim.keymap.set("n", "<c-n>", ":CHADopen<CR>") -- todo: make this pure lua?

----------------------------------------------------------------------------
-- coq + lsp-config : autocompletion, docs and more
----------------------------------------------------------------------------

vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = { eval_snips = '<leader>j' }
}

local lspconfig = require('lspconfig')
local coq = require('coq')

-- Setup LSP and attach coq
local servers = {
  'gopls',
  'phpactor',
  'tsserver',
  'terraformls',
  'zls',
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({}))
end

lspconfig.eslint.setup(coq.lsp_ensure_capabilities({
  on_attach = function(client, bufnr)
    -- fix eslint issues on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}))

-- open a diagnostic float on a problem
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
-- jump between problems
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- open a list of problems
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- On attach of any language server...
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    -- jump to declaration
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- jump to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- show hover docs
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
    -- jump to implementation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- rename token
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- open a list of references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- format document
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- Additional plugins
require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
  { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
  { src = "bc", short_name = "MATH", precision = 6 },
}

----------------------------------------------------------------------------
-- lsp_signature : floats a little window with function signature help
----------------------------------------------------------------------------

--require("lsp_signature").setup({
--  doc_lines = 0,
--  transparency = 80,
--   close_timeout = 500,
--   auto_close_after = 5000,
--   zindex = 10,
-- })
-- 
-- -- Toggle signature window with leader-k in normal mode
-- vim.keymap.set({ 'n' }, '<Leader>k', function()
--      vim.lsp.buf.signature_help()
--     end, { silent = true, noremap = true, desc = 'toggle signature' })

require('colorizer').setup({
  filetypes = {
    '*',
    css = { names = true },
    javascript = { names = true },
    html = { names = true },
  },
  user_default_options = {
    names = false,
  }
})

