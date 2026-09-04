-- Language servers. Neovim has the LSP client built in, so no plugin is needed.
-- Each server is defined in lsp/<name>.lua and switched on with one line here.
-- Keymaps are nvim defaults: see :help lsp-defaults

vim.lsp.enable('lua_ls')
