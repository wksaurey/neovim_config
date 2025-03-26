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

      -- Setup telescope with custom mappings
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              -- Map Ctrl-v to vertical split
              ['<C-s>'] = require('telescope.actions').file_vsplit,
            },
            n = {
              ['<C-s>'] = require('telescope.actions').file_vsplit,
            },
          },
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      -- Load the extension after setup
      require('telescope').load_extension('ui-select')
    end,
  },
}
