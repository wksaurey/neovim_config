return {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
        local leap = require('leap')
        leap.create_default_mappings()

        local user = require('leap.user')
        user.set_repeat_keys('<enter>', '<backspace>')
    end
}
