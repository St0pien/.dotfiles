local dap = require('dap')

vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>c', function() dap.set_breakpoint(vim.fn.input('Condition: '), nil, nil) end)
vim.keymap.set('n', '<leader>tr', function() dap.terminate() end)


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

-- Debug signs config
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#ff6666', bg = 0 })
vim.api.nvim_set_hl(0, 'DapStopped', { bg = '#1a1a1a' })

vim.fn.sign_define('DapBreakpoint', { text = '⏺', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapStopped', { text = '➤', linehl = 'DapStopped' })


-- virtual text
require('nvim-dap-virtual-text').setup()

vim.keymap.set('n', '<leader>db', ui.toggle)

-- Python
local dapPython = require('dap-python')
dapPython.setup('~/.virtualenvs/debugpy/bin/python')

-- C++
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7'
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

-- Rust
dap.adapters.lldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- CHANGE THIS to your path!
        command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
        args = { "--port", "${port}" },
    }
}

dap.configurations.rust = {

    {
        name = "Debug file",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}"
    }
}


vim.keymap.set('n', '<F5>', function()
    local dapvscode = require('dap.ext.vscode')
    if vim.fn.filereadable('.vscode/launch.json') then
        dapvscode.load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
    end
    dap.continue()
end)
