vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Use Ctrl + [hjkl] to navigate between splits
vim.keymap.set('n', '<C-k>', '<Cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', '<Cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', '<Cmd>wincmd l<CR>', { silent = true })

-- move highlighted lines togther
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- keep curser where is is when appending lower line to current line
vim.keymap.set('n', 'J', 'mzJ`z')

-- keep curser centered in the screen when jumping around
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- keep curser centered in the screen when searching through file
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- preserve paste buffer when pasting over highlighted word
vim.keymap.set('x', '<leader>p', '\"_dp')

-- preserve paste buffer when deleting highlighted word
vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')

-- enable system clipboard integration with wsl
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = "WSL Clipboard",
        copy = {
            ["+"] = function(text) vim.fn.system('clip.exe', text) end,
            ["*"] = function(text) vim.fn.system('clip.exe', text) end,
        },
        cache_enabled = 0,
    }
end

-- use <leader>y to copy to system keyboard
vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

-- removes 'Q' functionality (apparently it's bad?)
vim.keymap.set('n', 'Q', '<nop>')

-- replaces the current highlighted word throughout all of file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--sets current file as executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
