return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')


        -- define helper
        local function safe_select(idx)
            local list = harpoon:list()
            if list.items[idx] then
                list:select(idx)
            end
        end
        
        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
        vim.keymap.set('n', '<leader>e', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- quick list
        -- vim.keymap.set('n', '<leader>j', function() harpoon:list():select(1) end)
        -- vim.keymap.set('n', '<leader>k', function() harpoon:list():select(2) end)
        -- vim.keymap.set('n', '<leader>l', function() harpoon:list():select(3) end)
        -- vim.keymap.set('n', '<leader>;', function() harpoon:list():select(4) end)

        vim.keymap.set('n', '<leader>j', function() safe_select(1) end)
        vim.keymap.set('n', '<leader>k', function() safe_select(2) end)
        vim.keymap.set('n', '<leader>l', function() safe_select(3) end)
        vim.keymap.set('n', '<leader>;', function() safe_select(4) end)

        -- <leader>h1..h9 dropped: it made <leader>h a prefix and stalled the
        -- Alpha dashboard 1s. Deeper slots go through the menu instead.

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set('n', '<leader>n', function() harpoon:list():prev() end)
        vim.keymap.set('n', '<leader>m', function() harpoon:list():next() end)
    end
}


