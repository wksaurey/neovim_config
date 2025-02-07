return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        vim.keymap.set('n', 'gh', '<cmd>diffget //2<CR>')
        vim.keymap.set('n', 'gl', '<cmd>diffget //3<CR>')
    end
}
