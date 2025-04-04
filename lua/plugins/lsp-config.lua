return {
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = { 'lua_ls', 'pylsp', 'marksman', 'bashls' },
			})
		end,
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- make zsh files recognized as sh for bash-ls & treesitter
			vim.filetype.add({
				extension = {
					zsh = 'sh',
					sh = 'sh', -- force sh-files with zsh-shebang to still get sh as filetype
				},
				filename = {
					['.zshrc'] = 'sh',
					['.zshenv'] = 'sh',
				},
			})

			-- completion connection to lsps
			-- add to each lsp for completion
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local lspconfig = require('lspconfig')

			-- lsp servers
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- pylsp config
			lspconfig.pylsp.setup({
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								maxLineLength = 150,
							},
						},
					},
				},
				capabilities = capabilities,
			})
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			-- end lsp servers

			-- keymaps
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
		end,
	},
}
