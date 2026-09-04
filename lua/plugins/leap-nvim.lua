return {
    -- upstream left GitHub 2026-03-21; ggandor/leap.nvim installs no lua/ now
    url = 'https://codeberg.org/andyg/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
        local leap = require('leap')
        vim.keymap.set({'n', 'x', 'o'}, '<leader>s',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, '<leader>S',  '<Plug>(leap-backward)')
        -- leap-from-window dropped: it collided with fugitive's <leader>gs

        local user = require('leap.user')
        user.set_repeat_keys('<enter>', '<backspace>')
    end
}
