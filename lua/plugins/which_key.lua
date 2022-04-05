if not pcall(require, "which-key") then
  return
end

-- Help for which key
vim.api.nvim_set_keymap('n', '<Leader>?', "<Esc>:WhichKey '' n<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>?', "<Esc>:WhichKey '' v<CR>", { noremap = true, silent = true })


-- https://github.com/folke/which-key.nvim#colors
vim.cmd([[highlight default link WhichKey          htmlH1]])
vim.cmd([[highlight default link WhichKeySeperator String]])
vim.cmd([[highlight default link WhichKeyGroup     Keyword]])
vim.cmd([[highlight default link WhichKeyDesc      Include]])
vim.cmd([[highlight default link WhichKeyFloat     CursorLine]])
vim.cmd([[highlight default link WhichKeyValue     Comment]])

require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20 -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true -- bindings for prefixed with g
    }
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local keymaps = {
    ["<F1>"]      = ' find help tags',
    ["<C-\\>"]    = 'Launch scratch terminal',
    ["<C-L>"]     = 'Clear and redraw screen',
    ["<C-K>"]     = ' find work dirs',
    ["<C-P>"]     = ' find files',
    ["."]         = 'Repeat last edit',
    ['c.']        = 'search and replace word under cursor',
    ["<up>"]      = 'Go up visual line',
    ["<down>"]    = 'Go down visual line',
    ["K"]         = 'LSP hover info under cursor',
    ["<leader>"] = {
        ['?'] = 'which key help',
        ['"'] = 'toggle IndentBlankline on/off',
        ['<F1>']    = 'Fuzzy find help tags',
        ['<Up>']    = 'horizontal split increase',
        ['<Down>']  = 'horizontal split decrease',
        ['<Left>']  = 'vertical split decrease',
        ['<Right>'] = 'vertical split increase',
        ['%']       = "change pwd to current file's parent",
        [';']       = ' buffers',
        ['=']       = 'normalize split layout',
        ['|']       = 'toggle color column on/off',
        ['\'']      = "toggle 'listchars' on/off",
        ['c.']      = 'search and replace WORD under cursor',
        b = {
                name = '+buffer',
                d = 'delete buffer'
        },
        e = {
                name = '+explore/edit',
                a = ' ~/.config/alacritty',
                e = { ':NvimTreeToggle<CR>', 'nvim-tree on/off' },
                f = { ':NvimTreeFindFile<CR>', 'nvim-tree current file' },
                n = ' ~/.config/nvim',
                i = "edit 'nvim/init.lua'",
                k = "edit 'nvim/keymaps.lua'",
                p = ' nvim plugins'
            },
        f = {
                name = '+find (fzf)',
                ['?'] = 'fzf-lua builtin commands',
                ["/"] = ' search history',
                [':'] = ' commands history',
                ['"'] = ' registers',
                p = 'files',
                g = 'git files',
                s = 'git status',
                S = 'git status (fullscreen)',
                C = 'git commits (project)',
                c = 'git commits (buffer)',
                H = 'file history (all)',
                h = 'file history (cwd)',
                B = 'buffer lines',
                b = 'live grep (buffer)',
                l = 'live grep (project)',
                R = 'live grep (repeat)',
                f = 'grep last search term',
                r = 'grep prompt',
                v = 'grep visual selection',
                w = 'grep word under cursor',
                W = 'grep WORD under cursor',
                M = 'man pages',
                m = 'marks',
                o = 'color schemes',
                O = 'highlight groups',
                q = 'quickfix list',
                Q = 'location list',
                x = 'neovim commands',
                k = 'neovim keymaps',
                z = 'spell suggestions under cursor',
                t = 'tags (buffer)',
                T = 'tags (project)',
            },
        g = {
                name = '+git',
                g = 'Gedit',
                s = 'git status',
                r = 'Gread (reset)',
                w = 'Gwrite (stage)',
                a = 'git add (current file)',
                A = 'git add (all)',
                b = 'git blame',
                B = 'git branches',
                c = 'git commit',
                d = 'git diff (buffer)',
                D = 'git diff (project)',
                S = 'git stash (current file)',
                ['-'] = 'git stash (global)',
                ['+'] = 'git stash pop',
                p = 'git push',
                P = 'git pull',
                f = 'git fetch --all',
                F = 'git fetch origin',
                l = 'git log (current file)',
                L = 'git log (global)',
                e = 'Gedit HEAD~n (vertical)',
                E = 'Gedit HEAD~n (horizontal)',
             },
        h = {
            name = '+gitsigns',
            b = 'git blame',
            p = 'preview hunk',
            r = 'reset hunk',
            R = 'reset buffer',
            s = 'stage hunk',
            u = 'undo stage hunk',
        },
        l = {
            name = '+lsp',
            a = 'code actions',
            d = 'definitions',
            D = 'declarations',
            y = 'type definitions',
            c = 'clear diagnostics',
            g = 'diagnostics (buffer)',
            G = 'diagnostics (project)',
            m = 'implemtations',
            s = 'symbols (buffer)',
            S = 'symbols (project)',
            r = 'references',
            R = 'rename',
            l = 'line diagnostics',
            t = 'toggle diagnostics',
            L = 'code lense',
            Q = 'send diagnostics to loclist',
        },
        t = {
             name = '+tab',
             n = 'open a new tab',
             c = 'close current tab',
             o = 'close all other tabs (:tabonly)',
             O = 'jump to first tab and close all others',
             z = 'zoom current tab (tmux-z)',
         },
        k = 'peek definition  (LSP)',
        K = 'signature help   (LSP)',
        m = 'open :messages',
        M = 'clear :messages',
        O = 'newline above (no insert-mode)',
        o = 'newline below (no insert-mode)',
        q = {
            name = '+quickfix/location_list',
            q = 'quickfix',
            l = 'location list'
        },
        Q = 'Quit nvim',
        w = {
            name = '+window',
            h = 'jump to right window',
            j = 'jump to bottom window',
            k = 'jump to top window',
            l = 'jump to left window',
            ['-'] = 'horizontal split',
            ['|'] = 'vertically split',
            d = 'close window',
            s = 'save buffer in current window'
        },
    },
    ['g'] = {
        ['<C-V>'] = 'visually select last yanked/pasted text',
        A = 'code action (LSP)',
        c = 'comment (motion)',
        cc = 'comment (line)',
        d = 'goto definition (LSP)',
        D = 'goto declaration (LSP)',
        m = 'goto implementation (LSP)',
        y = 'goto type definition (LSP)',
        r = 'references to quickfix (LSP)',
        R = 'rename (LSP)',
        x = 'REPL send to terminal (motion)',
        xx = 'REPL send to terminal (line)',
        -- builtin commands
        -- workaround for words being highlighted
        ['*'] = { 'g*:nohl<cr>', 'goto next word under cursor' },
        ['#'] = { 'g#:nohl<cr>', 'goto prev word under cursor' },
        ['<C-G>'] = 'show current curosr pos info',
        ['%'] = 'goto previous matching group',
        ['<'] = 'display last !command output',
        ['0'] = 'goto line start (nowrap)',
        ['$'] = 'goto line end  (nowrap)',
        ['8'] = 'print hex value under cursor',
        _ = 'goto last non-EOL char',
        E = 'Previous end of WORD',
        I = 'insert at first column',
        t = 'goto next tab',
        T = 'goto prev tab',
        -- m = { 'gm', 'goto middle of screen line' },
        M = 'goto middle of text line',
        F = 'Goto file:line under cursor',
    },
    ['['] = {
            -- ['%'] = 'matching group prev',
            ['-'] = 'goto older error list',
            c = 'diff (change) prev',
            D = 'diagnostics prev (nowrap)',
            d = 'diagnostics prev (wrap)',
            t = 'tab prev',
            T = 'tab first',
            l = 'location prev',
            L = 'location first',
            b = 'buffer prev',
            B = 'buffer first',
            q = 'quickfix prev',
            Q = 'quickfix first',
            [']'] = 'Previous class/object start',
            ['['] = 'Previous class/object end',
        },
    [']'] = {
            -- ['%'] = 'matching group next',
            ['+'] = 'goto newer error list',
            c = 'diff (change) next',
            D = 'diagnostics next (nowrap)',
            d = 'diagnostics next (wrap)',
            t = 'tab next',
            T = 'tab last',
            l = 'location next',
            L = 'location last',
            b = 'buffer next',
            B = 'buffer last',
            q = 'quickfix next',
            Q = 'quickfix last',
            [']'] = 'Next class/object start',
            ['['] = 'Next class/object end',
        }
}

local wk = require("which-key")
wk.register(keymaps, opts)

