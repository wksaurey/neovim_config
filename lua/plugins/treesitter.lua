-- nvim-treesitter `main` branch is a parser manager only: highlighting and
-- indentation moved into Neovim core, so the FileType autocmd below starts them
-- and stands in for the old auto_install.
--
-- Do NOT "upgrade" ~/.local/bin/tree-sitter to meet the documented 0.26.1
-- minimum. Every prebuilt above 0.25.10 is linked against glibc 2.39 and this
-- host has 2.35. 0.25.10 compiles everything here, tested against teal.
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- upstream: "This plugin does not support lazy-loading."
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')

        -- seeded from the 24 the old auto_install had accumulated
        local ensure = {
            'bash', 'c', 'c_sharp', 'cmake', 'cpp', 'devicetree', 'diff',
            'git_config', 'gitcommit', 'gitignore', 'html', 'htmldjango',
            'java', 'javascript', 'json', 'lua', 'markdown', 'python',
            'requirements', 'ssh_config', 'vim', 'vimdoc', 'xml', 'yaml',
        }

        local installed = ts.get_installed()
        local missing = vim.tbl_filter(function(lang)
            return not vim.tbl_contains(installed, lang)
        end, ensure)
        if #missing > 0 then
            ts.install(missing)
        end

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('kolter_treesitter', { clear = true }),
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(ev.match)
                if not lang then
                    return
                end

                local function start()
                    if not vim.api.nvim_buf_is_valid(ev.buf) then
                        return
                    end
                    -- a parser can be present but fail to load, and that must
                    -- not stop the file opening
                    if pcall(vim.treesitter.start, ev.buf, lang) then
                        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end

                if vim.tbl_contains(ts.get_installed(), lang) then
                    start()
                elseif vim.tbl_contains(ts.get_available(), lang) then
                    ts.install({ lang }):await(vim.schedule_wrap(start))
                end
            end,
        })
    end,
}
