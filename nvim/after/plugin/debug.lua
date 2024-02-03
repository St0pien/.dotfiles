local dap = require('dap')

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint)


-- UI
local ui = require('dapui')
ui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
    ui.open()
end
dap.listeners.after.event_terminated['dapui_config'] = function()
    ui.close()
end
dap.listeners.after.event_exited['dapui_config'] = function()
    ui.close()
end


-- virtual text
require('nvim-dap-virtual-text').setup()

vim.keymap.set('n', '<leader>db', ui.toggle)

-- Python
local dapPython = require('dap-python')
dapPython.setup('~/.virtualenvs/debugpy/bin/python')


