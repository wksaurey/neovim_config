return {
	'goolord/alpha-nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},

	config = function()
		local alpha = require('alpha')
		local dashboard = require('alpha.themes.dashboard')

		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
        }

        -- Font Awesome codepoints on purpose: Nerd Fonts v3 moved the Material
        -- Design block, and Jomolhari squats the vacated PUA slots so the old
        -- ones render as Tibetan glyphs instead of tofu
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("s", "  Search text", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e ~/.config/nvim/lua/plugins/alpha.lua<CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        local function footer()
            return "Don't Stop Until You are Proud..."
        end

        dashboard.section.footer.val = footer()

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"

        dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)

        -- home map
        vim.keymap.set('n', '<leader>h', vim.cmd.Alpha)
	end,
}
