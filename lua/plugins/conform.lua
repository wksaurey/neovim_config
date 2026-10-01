-- Formatting is <leader>f only, never format-on-save: reformatting a whole file
-- on every write makes a mid-assignment diff unreadable.
-- Declared under keys= rather than in config= so lazy binds the key up front;
-- a keymap created inside config() does not exist until something else has
-- already loaded the plugin.
return {
    'stevearc/conform.nvim',
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format({ async = true, lsp_format = 'fallback' })
            end,
            mode = { 'n', 'x' },
            desc = 'Format buffer',
        },
    },
    opts = {
        formatters_by_ft = {
            java = { 'google-java-format' },
        },
    },
}
