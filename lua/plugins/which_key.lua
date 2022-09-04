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
  triggers = { "<leader>", "<localleader>" },
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local leader_opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}   

local localleader_opts = {
    mode = "n", -- NORMAL mode
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    prefix = "<localleader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local localleaderkeymaps = {
    a = {
          name = "+code actions",
          a = "lsp_code_actions"
        },
    g = {
          name = "+goto",
          r = "find references",
          d = "goto definition",
          D = "goto declaration",
          t = "goto type definition",
          i = "goto implementation",
          s = "goto worksapce symbols"
        },
    G = {
          s = "signature help",
          d = "peek definition"
        },
    r = {
          name = "+refactor",
          r = "lsp rename"
        }
}

local leaderkeymaps = {
    ["<F1>"]    = 'Find help tags',
    ["<C-\\>"]  = 'Launch scratch terminal',
    ["<tab>"]   = 'Next Buffer',
    ["<C-L>"]   = 'Clear and redraw screen',
    ["<C-K>"]   = 'Find work dirs',
    ["<C-P>"]   = 'Find files',
    ["\""]      = 'Toggle IndentBlankline on/off',
    ["\'"]      = 'Toggle List Chars',
    ["/"]       = 'Grep Project',
    ["="]       = 'Balance windows area',
    ["%"]       = "Change pwd to current file's parent",
    ["."]       = 'Repeat last edit',
    ["?"]       = 'Whichkey Help',
    ['c.']      = 'Search and replace word under cursor',
    ['|']       = 'Toggle color column on/off',
    ['TAB']     = 'Next Buffer',
    ["<up>"]    = 'Go up visual line',
    ["<down>"]  = 'Go down visual line',
    ['<Left>']  = 'vertical split decrease',
    ['<Right>'] = 'vertical split increase',
    b           = {
                      name = '+buffer',
                      b = 'buffers',
                      n = 'next buffer',
                      d = 'delete buffer',
                      f = 'first buffer',
                      l = 'last buffer'
                  },
    e           = {
                      name = '+explore/edit',
                      a = ' ~/.config/alacritty',
                      e = { ':NvimTreeToggle<CR>', 'nvim-tree on/off' },
                      f = { ':NvimTreeFindFile<CR>', 'nvim-tree current file' },
                      i = "edit 'nvim/init.lua'",
                      k = "edit 'nvim/keymaps.lua'",
                      p = 'nvim plugins',
                      o = "~/.config/omf"
                      },
    f           = {
                      name = '+files/fzf',
                      ['?'] = 'fzf-lua builtin commands',
                      ["/"] = 'search history',
                      [':'] = 'commands history',
                      ['"'] = 'registers',
                      s = 'save file',
                      B = 'buffer lines',
                      f = 'find file',
                      r = 'recent file (all)',
                      R = 'recent file (cwd)',
                      v = 'grep visual selection',
                      w = 'grep word under cursor',
                      W = 'grep WORD under cursor',
                      m = 'man pages',
                      M = 'marks',
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
    g           = {
                      name = '+git',
                      s = 'git status',
                      r = 'Gread (reset)',
                      w = 'Gwrite (stage)',
                      a = 'git add (current file)',
                      A = 'git add (all)',
                      b = 'git blame',
                      B = 'git branches',
                      c = 'git commit',
                      S = 'git stash (current file)',
                      ['-'] = 'git stash (global)',
                      ['+'] = 'git stash pop',
                      f = {
                              name = '+files/fetch',
                              f = 'git files',
                              r = 'git fetch remote',
                              a = 'git fetch all'
                          },
                      h = {
                             name = '+hunk',
                             p = 'preview hunk',
                             s = 'stage hunk',
                             r = 'reset hunk',
                             R = 'reset buffer',
                             u = 'undo stage hunk'
                          },
                      l = 'git log (current file)',
                      L = 'git log (global)',
                      ['/'] = 'git-grep',
                      ['*'] = 'git-grep-at-point'
                   },
    h           = {
                  name = '+help',
                  t = 'Help tags'
    },
    l           = {
                  name = '+lsp',
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
    t           = {
                      name = '+tab',
                      c = 'create a new tab',
                      d = 'delete current tab',
                      p = 'previous tab',
                      n = 'next tab',
                      o = 'close all other tabs (:tabonly)',
                      O = 'jump to first tab and close all others',
                      z = 'zoom current tab (like tmux-z)',
                  }          ,
    m           = 'open :messages',
    M           = 'clear :messages',
    q           = {
                      name = '+quickfix/quit',
                      q = 'quit nvim',
                      l = 'quickfix list'
                  },
    Q           = 'Quit nvim',
    w           = {
                      name = '+window',
                      h = 'jump to right window',
                      j = 'jump to bottom window',
                      k = 'jump to top window',
                      l = 'jump to left window',
                      ['-'] = 'horizontal split',
                      ['|'] = 'vertically split',
                      d = 'close window',
                      s = 'horizontally split',
                      v = 'vertically split'
                  },
    --[[ g = {
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
    }, ]]
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
wk.register(leaderkeymaps, leader_opts)
wk.register(localleaderkeymaps, localleader_opts)

