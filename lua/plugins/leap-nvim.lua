return {
    -- Upstream left GitHub on 2026-03-21 ("nuke it from orbit"); ggandor/leap.nvim
    -- is now an empty README pointing here, so the GitHub spec installs no lua/.
    url = 'https://codeberg.org/andyg/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
        local leap = require('leap')
        vim.keymap.set({'n', 'x', 'o'}, '<leader>s',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, '<leader>S',  '<Plug>(leap-backward)')
        -- leap-from-window removed: it collided with fugitive's <leader>gs (:Git),
        -- and window movement is already covered by <C-hjkl>.

        local user = require('leap.user')
        user.set_repeat_keys('<enter>', '<backspace>')
    end
}
