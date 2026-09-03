return {
    -- Upstream left GitHub on 2026-03-21 ("nuke it from orbit"); ggandor/leap.nvim
    -- is now an empty README pointing here, so the GitHub spec installs no lua/.
    url = 'https://codeberg.org/andyg/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
        local leap = require('leap')
        vim.keymap.set({'n', 'x', 'o'}, '<leader>s',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, '<leader>S',  '<Plug>(leap-backward)')
        vim.keymap.set({'n', 'x', 'o'}, '<leader>gs', '<Plug>(leap-from-window)')

        local user = require('leap.user')
        user.set_repeat_keys('<enter>', '<backspace>')
    end
}
