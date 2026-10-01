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
            surrounds = {
                -- Nothing stock produces a ``` fence: the backtick surround
                -- emits one character, so gS` gives a lone backtick line.
                ['C'] = {
                    add = function()
                        local lang = require('nvim-surround.config').get_input('Language: ')
                        return { { '```' .. (lang or '') }, { '```' } }
                    end,
                    find = '^```%S*\n.-\n```$',
                    delete = '^(```%S*\n)().-(\n```)()$',
                },
            },
            move_cursor = false,
        }
    end
}
