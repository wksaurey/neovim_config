return {
	'nvimtools/none-ls.nvim',
    dependancies = {
        'nvimtools/none-ls-extras.nvim'
    },
	config = function()
		local null_ls = require('null-ls')

		null_ls.setup({
			sources = {
                -- install with mason first
				null_ls.builtins.formatting.stylua.with({
					extra_args = { '--quote-style', 'AutoPreferSingle' },
				}),
				null_ls.builtins.completion.spell,
                null_ls.builtins.formatting.prettier,

                -- python
				null_ls.builtins.formatting.black.with({
					extra_args = { '--quote-style', 'AutoPreferSingle' },
				}),
                null_ls.builtins.formatting.isort,

			},
		})

        -- file format
		vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, {})
	end,
}
