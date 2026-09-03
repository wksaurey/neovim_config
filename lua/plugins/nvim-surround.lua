return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup {
            -- Using the plugin's default keymaps (ys / ds / cs / visual S).
            -- The old <leader>s* set shared a prefix with leap's <leader>s, which
            -- forced a 1s timeoutlen wait on every leap jump and let surround win
            -- <leader>s and <leader>S in visual mode, so leap never fired there.
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
