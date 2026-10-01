-- Each server is defined in lsp/<name>.lua and switched on with one line here.
-- Keymaps are nvim defaults: see :help lsp-defaults

vim.lsp.enable('lua_ls')
vim.lsp.enable('jdtls')
vim.lsp.enable('clangd')

-- noselect stops the first candidate being inserted as you type; menuone shows
-- the popup for a single match too, which is the case where accepting it is
-- the whole point (that one item carries the import edit).
vim.opt.completeopt:append({ 'menuone', 'noselect' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or not client:supports_method('textDocument/completion') then
            return
        end

        -- Servers ask to be triggered only on punctuation (jdtls: . @ # *), so
        -- typing an identifier would never open the popup. :help lsp-autocompletion
        local provider = client.server_capabilities.completionProvider
        if provider then
            local chars = provider.triggerCharacters or {}
            for byte = string.byte('a'), string.byte('z') do
                table.insert(chars, string.char(byte))
                table.insert(chars, string.char(byte):upper())
            end
            table.insert(chars, '_')
            provider.triggerCharacters = chars
        end

        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end,
})

-- Tab cycles the popup and is otherwise a literal Tab.
vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true, replace_keycodes = true })
vim.keymap.set('i', '<S-Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true, replace_keycodes = true })
