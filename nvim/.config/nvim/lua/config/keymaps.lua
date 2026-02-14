-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Copy
vim.keymap.set('v', '<C-c>', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set('v', '<C-x>', '"+d', { desc = "Cut to system clipboard" })
vim.keymap.set({'n', 'i'}, '<C-v>', '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set('v', '<C-v>', '"+p', { desc = "Paste from system clipboard" })

-- <Esc>
-- vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, desc = 'Escape insert mode' })
-- vim.keymap.set('t', 'jj', '<C-\\><C-n>', { noremap = true, desc = 'Escape terminal mode' })
-- jasldkjfasdlifj
-- Map Tab to Escape in Insert mode
-- vim.keymap.set("i", "<Tab>", "<Esc>")
-- vim.keymap.set("t", "<Tab>", "<Esc>")
