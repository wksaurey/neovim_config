-- lua-language-server -- https://luals.github.io
--
-- Neovim finds this file on its own: any `lsp/<name>.lua` on the runtimepath
-- is the definition for a server called <name>. Nothing reads it until
-- something calls vim.lsp.enable('lua_ls'), which lua/config/lsp.lua does.
--
-- Install: the binary lives in ~/.local/share/lua-language-server, symlinked
-- to ~/.local/bin/lua-language-server. To upgrade, replace that directory
-- with a newer release tarball from the GitHub releases page.

return {
    -- How to start the server. Must be findable on $PATH.
    cmd = { 'lua-language-server' },

    -- Only attach to Lua buffers.
    filetypes = { 'lua' },

    -- Walking up from the edited file, the first directory holding one of
    -- these names is treated as the project root, and the server indexes
    -- from there. Without a match it falls back to a single-file mode.
    root_markers = { '.luarc.json', '.luarc.jsonc', 'stylua.toml', '.git' },

    settings = {
        Lua = {
            -- Neovim embeds LuaJIT, not standard Lua 5.4, so the standard
            -- library it should check against is different.
            runtime = { version = 'LuaJIT' },

            workspace = {
                -- Load Neovim's own Lua runtime as a library. This is what
                -- makes `vim.` complete and stops `vim` being reported as an
                -- undefined global while editing this config.
                --
                -- Deliberately NOT the full runtimepath: adding every
                -- installed plugin would teach it plugin APIs too, at the
                -- cost of indexing all of them on every start. Widen this
                -- later if completing require('telescope') matters.
                library = { vim.env.VIMRUNTIME .. '/lua' },

                -- Suppress the "configure this project as luassert/busted?"
                -- prompt on unfamiliar directories.
                checkThirdParty = false,
            },

            -- Nothing here is uploaded anywhere, but the server asks on first
            -- run unless told.
            telemetry = { enable = false },
        },
    },
}
