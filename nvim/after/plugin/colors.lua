require('transparent')


function ColorMyPencils(color)
    require('base16-colorscheme').with_config({
        telescope = false
    })

    require('min-theme').setup({
        italics = {
            comments = false,
            keywords = false,
            functions = false,
            strings = false,
            variables = false,
        }
    })

    -- color = color or 'base16-black-metal'
    color = color or 'base16-black-metal'
    vim.cmd.colorscheme(color)

    vim.cmd('hi! LineNr guibg=none ctermbg=none')
    vim.cmd('hi! SignColumn guibg=none ctermbg=none')

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
