-- nvim-treesitter, `main` branch.
--
-- The `master` branch is frozen and its README states Neovim 0.12 is NOT
-- supported. On `main` the plugin is only a PARSER MANAGER: highlighting and
-- indentation moved into Neovim core, so we start them ourselves below.
-- There is no `ensure_installed`, no `highlight = {}`, no `indent = {}`, and
-- no `auto_install` -- the FileType autocmd at the bottom replaces the last one.
--
-- Requires the `tree-sitter` CLI on PATH to compile parsers. Note this host
-- runs Ubuntu 22.04 (glibc 2.35) and EVERY prebuilt CLI >= 0.26.1 (the
-- documented minimum) is linked against glibc 2.39, so none of them can run
-- here -- probed 0.26.1 through 0.27.0, all refuse to start. v0.25.10
-- (glibc 2.34) is installed at ~/.local/bin/tree-sitter instead.
--
-- That older CLI is fully sufficient: TESTED 2026-09-03 against `teal`, one of
-- only 8 grammars (of 323) that require generating parser.c from grammar.json
-- rather than shipping it pre-generated, and it generated + compiled it fine.
-- So the 0.26.1 floor is advisory here, not a real constraint.
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- upstream: "This plugin does not support lazy-loading."
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')

        -- Parsers to keep on disk. Seeded from the 24 that the old master-branch
        -- `auto_install` had accumulated, so day one behaves identically.
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

        -- One FileType hook does the two jobs the plugin used to do for us:
        -- fetch a parser we don't have yet (the old `auto_install`), and turn
        -- on highlighting + indentation (the old `highlight`/`indent` opts).
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
                    -- pcall: a parser can be present but fail to load, and a
                    -- broken parser must not break opening the file.
                    if pcall(vim.treesitter.start, ev.buf, lang) then
                        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end

                if vim.tbl_contains(ts.get_installed(), lang) then
                    start()
                elseif vim.tbl_contains(ts.get_available(), lang) then
                    -- Not installed yet: fetch it, then highlight when it lands.
                    ts.install({ lang }):await(vim.schedule_wrap(start))
                end
            end,
        })
    end,
}
