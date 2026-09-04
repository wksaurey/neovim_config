return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup {
            -- plugin defaults (ys/ds/cs/S). The old <leader>s* set shared a
            -- prefix with leap's <leader>s and stalled every leap jump 1s.
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
