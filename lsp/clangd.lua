-- clangd -- https://clangd.llvm.org
-- Enabled in lua/config/lsp.lua. Binary: ~/tools/clangd (GitHub release, no apt)

return {
    cmd = { vim.env.HOME .. '/tools/clangd/bin/clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git' },
}
