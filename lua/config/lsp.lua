-- Language servers.
--
-- Neovim 0.11+ has the LSP client built in, so none of this needs a plugin.
-- Each server gets its own file under `lsp/` at the root of this config
-- (see lsp/lua_ls.lua) and one line here to switch it on.
--
-- Adding a language later: write lsp/<name>.lua, add vim.lsp.enable('<name>')
-- below, install the server binary. Removing one: delete its line.
--
-- The useful keymaps are Neovim defaults and need no setup here:
--   K      hover documentation          grn  rename symbol everywhere
--   grr    list references              gra  code action
--   gri    go to implementation         grt  go to type definition
--   gO     document symbols             <C-S>  signature help (insert mode)
--   ]d / [d  next/previous diagnostic

vim.lsp.enable('lua_ls')
