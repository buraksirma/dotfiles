vim.keymap.set("", "<C-j>", "<C-W>j", { silent = true })
vim.keymap.set("", "<C-k>", "<C-W>k", { silent = true })
vim.keymap.set("", "<C-h>", "<C-W>h", { silent = true })
vim.keymap.set("", "<C-l>", "<C-W>l", { silent = true })

vim.keymap.set("n", "H", "^", { noremap = true })
vim.keymap.set("n", "L", "$", { noremap = true })
vim.keymap.set("v", "H", "^", { noremap = true })
vim.keymap.set("v", "L", "g_", { noremap = true })

vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("", "<leader>n", "<cmd>Oil<cr>", { noremap = true })

vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { noremap = true })
vim.keymap.set("v", "<leader>gb", "<cmd>Git blame<cr>", { noremap = true })
