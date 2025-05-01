-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>s", ":wa<CR>", { desc = "Save file with Command+S" })

-- Tab for indenting in visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selected text" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selected text" })

-- Inc rename
vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "LSP renaming" })

-- Redo hotkey
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })
