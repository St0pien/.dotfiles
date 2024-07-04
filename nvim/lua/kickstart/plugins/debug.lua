-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {
        -- function(config)
        --   require('mason-nvim-dap').default_setup(config)
        -- end,
        --
        -- cppdbg = function(config)
        --   config.adapters = {
        --     id = 'cppdbg',
        --     type = 'executable',
        --     command = vim.fn.stdpath 'data' .. '/mason/bin/OpenDebugAD7',
        --   }
        --
        --   config.configurations = {
        --     {
        --       name = 'Launch file my custom',
        --       type = 'cppdbg',
        --       request = 'launch',
        --       program = function()
        --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --       end,
        --       cwd = '${workspaceFolder}',
        --       stopAtEntry = true,
        --     },
        --     {
        --       name = 'Attach to gdbserver :1234',
        --       type = 'cppdbg',
        --       request = 'launch',
        --       MIMode = 'gdb',
        --       miDebuggerServerAddress = 'localhost:1234',
        --       miDebuggerPath = '/usr/bin/gdb',
        --       cwd = '${workspaceFolder}',
        --       program = function()
        --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --       end,
        --     },
        --   }
        --
        --   require('mason-nvim-dap').default_setup(config)
        -- end,
      },

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'cppdbg',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F9>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#ff6666', bg = 0 })
    vim.api.nvim_set_hl(0, 'DapStopped', { bg = '#1a1a1a' })

    vim.fn.sign_define('DapBreakpoint', { text = '⏺', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapStopped', { text = '➤', linehl = 'DapStopped' })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>db', dapui.toggle, { desc = 'Debug: See last session result.' })

    vim.keymap.set('n', '<leader>tr', function()
      require('dap').terminate()
    end)

    vim.keymap.set('n', '<leader>vrt', function()
      vim.api.nvim_buf_clear_namespace(0, -1, 0, -1)
    end)

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
