--- Credit to ibhagwan
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/pluginList.lua

local packer_startup = function(use)

    -- speed up 'require', must be the first plugin
    use { "lewis6991/impatient.nvim",
        config = "if vim.fn.has('nvim-0.6')==1 then require('impatient') end"
    }

    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true }

    -- Analyze startuptime
    -- use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
    use { 'dstein64/vim-startuptime', cmd = 'StartupTime' }

    -- tpope's plugins that should be part of vim
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }

    -- "gc" to comment visual regions/lines
    use { 'numToStr/Comment.nvim',
        config = "require('plugins.comment')",
        -- uncomment for lazy loading
        -- slight delay if loading in visual mode
        keys = {'gcc', 'gc', 'gl'}
    }

    -- Git wrapper for vim
    use { 'tpope/vim-fugitive',
        config = "require('plugins.fugitive')",
        event = "VimEnter" }

    -- plenary is required by gitsigns and telescope
    -- lazy load so gitsigns doesn't abuse our startup time
    use { "nvim-lua/plenary.nvim", event = "VimEnter" }


    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = "require('plugins.gitsigns')",
        after = "plenary.nvim"
    }

    -- key bindings cheatsheet
    use { 'folke/which-key.nvim',
        config = "require('plugins.which_key')",
        event = "VimEnter"
    }

    -- Add indentation guides
    use { 'lukas-reineke/indent-blankline.nvim',
        config = "require('plugins.indent-blankline')",
        event = 'BufRead',
        opt = true,
    }

    -- only required if you do not have fzf binary
    -- use = { 'junegunn/fzf', run = './install --bin', }
    use { 'ibhagwan/fzf-lua',
        setup = "require('plugins.fzf-lua.mappings')",
        config = "require('plugins.fzf-lua')",
        opt = true
    }

    -- optional for fzf-lua, telescope, nvim-tree
    use { 'kyazdani42/nvim-web-devicons',
      config = "require('plugins.devicons')",
      event = 'VimEnter'
    }

    -- nvim-tree
    use { 'kyazdani42/nvim-tree.lua',
        config = "require('plugins.nvim-tree')",
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        opt = true,
    }

    -- Autocompletion & snippets
    use { 'L3MON4D3/LuaSnip',
      config = 'require("plugins.luasnip")',
      event = 'InsertEnter' }

    use { 'hrsh7th/nvim-cmp',
        requires = {
          { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
          { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        },
        config = "require('plugins.cmp')",
        -- event = "InsertEnter", }
        after = 'LuaSnip', }

    -- better quickfix
    use { 'kevinhwang91/nvim-bqf',
       config = "require'plugins.bqf'",
       ft = { 'qf' } }

    -- statusline
    use { 'tjdevries/express_line.nvim',
       config = "require('plugins.statusline')",
       requires = { 'nvim-lua/plenary.nvim' },
       after = { 'plenary.nvim', 'nvim-web-devicons' },
       event = 'VimEnter',
    }

    -- Neoterm (REPLs)
    use { 'akinsho/toggleterm.nvim',
        config = "require('plugins.neoterm')",
        keys = {'gxx', 'gx', '<C-\\>'},
        cmd = { 'T' },
    }

    -- nvim-treesitter
    -- verify a compiler exists before installing
    if require'utils'.have_compiler() then
        use { 'nvim-treesitter/nvim-treesitter',
            config = "require('plugins.treesitter')",
            run = ':TSUpdate',
            event = 'BufRead' }
        use { 'nvim-treesitter/nvim-treesitter-textobjects',
            after = { 'nvim-treesitter' } }
        -- debuging treesitter
        use { 'nvim-treesitter/playground',
            after = { 'nvim-treesitter' },
            cmd = { 'TSPlaygroundToggle' },
            opt = true }
    end

    -- LSP
    use { 'neovim/nvim-lspconfig', event = 'BufRead' }
    use { 'williamboman/nvim-lsp-installer',
        config = "require('lsp')",
        after  = { 'nvim-lspconfig' },
    }

    -- Color scheme, requires nvim-treesitter
    vim.g.nvcode_termcolors = 256
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- -- ethereum solidity '.sol'
    use { 'tomlion/vim-solidity' }

    -- Colorizer
    use { 'norcalli/nvim-colorizer.lua',
        config = "require'colorizer'.setup()",
        cmd = {'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer' },
        opt = true }

    -- markdown preview
    use { 'ellisonleao/glow.nvim' }

    -- DAP
    use { 'mfussenegger/nvim-dap',
        config = "require('plugins.dap')",
        keys = {'<F5>', '<F8>', '<F9>' }
    }
    use { 'rcarriga/nvim-dap-ui',
        config = "require('plugins.dap.ui')",
        after = { 'nvim-dap' }
    }

    use { 'jbyuki/one-small-step-for-vimkind',
        after = { 'nvim-dap' }
    }

    -- AI Assistant
    use { 'github/copilot.vim' }

    -- Dash doc
    use({
        'mrjones2014/dash.nvim',
        run = 'make install',
    })
    
end


return packer_startup
