-- Change the leader
vim.g.mapleader = ","

-- =j indents as JSON
vim.keymap.set("n", "=j", [[:%!jq .<CR>]])

-- Expand %% into the current directory of the current file
vim.keymap.set("c", "%%", [[<C-R>=expand('%:h').'/'<cr>]], { noremap = true })

-- Remove extra whitespace
vim.keymap.set("n", "<leader><space>", [[:%s/\s\+$<cr>]])

-- Replace word with yanked text
vim.keymap.set("x", "<leader>p", [["_dP]])

--------------
-- Buffers
--------------

-- Next/Prev Buffer
vim.keymap.set("n", "<leader>n",  [[:bn<CR>]])
vim.keymap.set("n", "<leader>p", [[:bp<CR>]])

-- Close Buffer but not split
vim.keymap.set("n", "<leader>q", [[:Bdelete<CR>]])
vim.keymap.set("n", "<c-d>", [[:Bdelete<CR>:bn<CR>]], { silent = true })

-- Close all other Buffers
vim.keymap.set("n", "<leader>bo", [[:BufOnly<CR>]], { noremap = true, silent = true })

-- Switch between current and last buffer
vim.keymap.set("n", "<leader>,", "<c-^>")
