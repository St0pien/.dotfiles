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
local virt = require('nvim-dap-virtual-text')
virt.setup({
    clear_on_continue = false
})

vim.keymap.set('n', '<leader>vrt', function()
    vim.api.nvim_buf_clear_namespace(0, -1, 0, -1)
    require('rainbow-delimiters').enable();
end)

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

-- JS/TS
local jsts = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
}

for _, language in ipairs(jsts) do
    dap.configurations[language] = {
        -- Debug single nodejs files
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
                local co = coroutine.running()
                return coroutine.create(function()
                    vim.ui.input({
                        prompt = "Enter URL: ",
                        default = "http://localhost:3000",
                    }, function(url)
                        if url == nil or url == "" then
                            return
                        else
                            coroutine.resume(co, url)
                        end
                    end)
                end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
        },

    }
end


require("dap-vscode-js").setup({
    -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- node_path = "node",

    -- Path to vscode-js-debug installation.
    debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug"),

    -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
    -- debugger_cmd = { "js-debug-adapter" },

    -- which adapters to register in nvim-dap
    adapters = {
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "pwa-extensionHost",
        "node-terminal",
    },

    -- Path for file logging
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

    -- Logging level for output to file. Set to false to disable logging.
    -- log_file_level = false,

    -- Logging level for output to console. Set to false to disable console output.
    -- log_console_level = vim.log.levels.ERROR,
})


vim.keymap.set('n', '<F5>', function()
    local dapvscode = require('dap.ext.vscode')

    if vim.fn.filereadable('.vscode/launch.json') then
        dapvscode.load_launchjs(nil, {
            cppdbg = { 'c', 'cpp' },
            ['pwa-node'] = jsts,
            ['pwa-chrome'] = jsts,
            ['chrome'] = jsts
        })
    end
    dap.continue()
end)
