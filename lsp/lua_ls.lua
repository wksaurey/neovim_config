-- lua-language-server -- https://luals.github.io
-- Enabled in lua/config/lsp.lua. Binary: ~/.local/bin/lua-language-server

return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', 'stylua.toml', '.git' },

    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' }, -- nvim embeds LuaJIT, not Lua 5.4
            workspace = {
                -- the vim API. Not the full rtp, which would index every plugin.
                library = { vim.env.VIMRUNTIME .. '/lua' },
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}
