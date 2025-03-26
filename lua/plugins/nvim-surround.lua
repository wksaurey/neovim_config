return {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup {
            keymaps = {
                normal = '<leader>sa',
                normal_cur = '<leader>sas',
                normal_line = false,
                normal_cur_line = false,
                visual = '<leader>s',
                visual_line = '<leader>S',
                delete = '<leader>sd',
                change = '<leader>sr',
            },
            aliases = {
                ['s'] = ']', -- Index
                ['p'] = ')', -- Parenthasis
                ['c'] = '}', -- Curly Brackets
                ['u'] = '__', -- Curly Brackets
            },
            move_cursor = false,
        }
    end
}
