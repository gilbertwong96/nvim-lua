--- Credit to ibhagwan
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/bqf.lua

require('bqf').setup({
    auto_enable = true,
    auto_resize_height = true,
    preview = {
        auto_preview = false,
    },
    func_map = {
        -- ptoggleauto = '<F2>',
        -- ptogglemode = '<F3>',
        split       = '<C-s>',
        vsplit      = '<C-v>',
        pscrollup   = '<S-up>',
        pscrolldown = '<S-down>',
    },
    filter = {
        fzf = {
            action_for = {['ctrl-s'] = 'split'},
            extra_opts = {'--bind', 'ctrl-a:toggle-all', '--prompt', '> '}
        }
    }
})
