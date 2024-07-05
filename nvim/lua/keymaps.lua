-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>r', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move line up/down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move block up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move block down' })

-- Freeze cursor during line joining
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line below' })

-- Keep cursor centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Paste into
vim.keymap.set('x', '<leader>p', [["_dP]])

-- System clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Fuzzy finders
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww $REPOS/.dotfiles/shcripts/repofinder.sh<CR>')
vim.keymap.set('n', '<leader>tm', '<cmd>silent !tmux neww $REPOS/.dotfiles/shcripts/tmuxfinder.sh<CR>')

-- quick/location navigation
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- window resizing
vim.keymap.set('n', '<M-l>', '<cmd>vertical resize +5<cr>')
vim.keymap.set('n', '<M-h>', '<cmd>vertical resize -5<cr>')
vim.keymap.set('n', '<M-j>', '<cmd>horizontal resize +5<cr>')
vim.keymap.set('n', '<M-k>', '<cmd>horizontal resize -5<cr>')

vim.keymap.set('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<leader>gi', '<cmd>Sleuth<CR>', { desc = '[G]uess [I]ndent' })
