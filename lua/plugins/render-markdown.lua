-- Renders headings, tables, code blocks and lists in the buffer while editing.
-- The cursor's own line stays raw source (anti_conceal, on by default), so the
-- line being edited is never hidden.

-- The plugin's stock icons cycle on nesting level alone, so `-` and `*` render
-- identically and the rendered buffer stops showing which marker the file
-- actually uses. Marker picks the shape, nesting level picks the variant.
-- Edit this table to change the glyphs; geometric shapes are deliberate, they
-- survive a terminal without a Nerd Font.
local bullets = {
    ['-'] = { '●', '○', '▪' },
    ['*'] = { '◆', '◇', '▸' },
    ['+'] = { '■', '□', '▫' },
}

return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'markdown' },
    keys = {
        {
            '<leader>M',
            '<Cmd>RenderMarkdown buf_toggle<CR>',
            ft = 'markdown',
            desc = 'Toggle markdown rendering (this buffer)',
        },
    },
    opts = {
        bullet = {
            icons = function(ctx)
                local shapes = bullets[vim.trim(ctx.value)] or bullets['-']
                return shapes[(ctx.level - 1) % #shapes + 1]
            end,
        },
    },
}
