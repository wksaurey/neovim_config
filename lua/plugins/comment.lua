return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()

        local api = require('Comment.api')
        --
        -- Helper to toggle line comment in insert mode
        local function toggle_line_insert()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
            api.toggle.linewise.current()
            vim.api.nvim_feedkeys('', 'n', false)
        end

        -- Normal mode
        vim.keymap.set('n', '<leader>c', api.toggle.linewise.current, { desc = 'Comment line' })
        vim.keymap.set('n', '<leader>C', api.toggle.blockwise.current, { desc = 'Block comment' })
        vim.keymap.set('n', '<C-_>', api.toggle.linewise.current, { desc = 'Comment line' })

        -- Visual mode (use plugin's <Plug> mappings)
        vim.keymap.set('x', '<leader>c', '<Plug>(comment_toggle_linewise_visual)')
        vim.keymap.set('x', '<leader>C', '<Plug>(comment_toggle_blockwise_visual)')
        vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')

        -- Insert mode(use toggle_line_insert helper function)
        vim.keymap.set('i', '<C-_>', toggle_line_insert, { desc = 'Comment line (insert mode)' })
    end
}

