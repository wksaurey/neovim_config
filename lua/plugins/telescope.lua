-- plugins/telescope.lua:
return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'Telescope find git files' })
			vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
		end,
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		config = function()
			require('telescope').setup({
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown({}),
					},
				},
                pickers = {
                    find_files = {
                        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    }
                }
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require('telescope').load_extension('ui-select')
		end,
	},
}
