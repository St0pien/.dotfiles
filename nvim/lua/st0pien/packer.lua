-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    -- Utilities
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('numToStr/Comment.nvim')
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    })
    use('HiPhish/rainbow-delimiters.nvim')

    -- color scheme
    use 'RRethy/nvim-base16'
    -- use 'metalelf0/base16-black-metal-scheme'
    use 'datsfilipe/min-theme.nvim'

    use 'xiyaowong/transparent.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- parsing syntax highlighting and lsp
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            -- {'williamboman/mason.nvim'},
            -- {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use 'onsails/lspkind.nvim'

    -- Formatting stuff

    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')

    use 'm4xshen/autoclose.nvim'
    use 'windwp/nvim-ts-autotag'

    -- using packer.nvim
    use {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    }
    -- icons
    use 'nvim-tree/nvim-web-devicons'

    -- debugging
    use 'nvim-neotest/nvim-nio'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'

    use 'mfussenegger/nvim-dap-python'
    use {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    }
end)
