local map = vim.keymap.set

-- Setting leader to space
vim.g.mapleader = " "
vim.keymap.set('n', '<Leader>o', function()
  vim.api.nvim_command('normal! o<Esc>')
end, { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>e', ':Ex<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':noh<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

