local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

local plugins = {
  "tanvirtin/monokai.nvim",
  "lunarvim/colorschemes", -- a bunch of snippets to use
  "nvim-lua/plenary.nvim",
  "windwp/nvim-autopairs",
  "gpanders/editorconfig.nvim",
  "belltoy/prom.vim",
  "christoomey/vim-tmux-navigator",
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end
  },
  "rainbowhxch/accelerated-jk.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",
  "johnfrankmorgan/whitespace.nvim",
  { "moll/vim-bbye", lazy = true },
  { "nvim-telescope/telescope.nvim", lazy = true},
  { "nvim-telescope/telescope-media-files.nvim", lazy = true },
  { "ahmedkhalf/project.nvim", lazy = true },
  "lukas-reineke/indent-blankline.nvim",
  "folke/which-key.nvim",

  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function ()
      require("colorizer").setup()
    end,
    cmd = { 'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer' }
  },

   -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",

  -- snippets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- Treesitter
  {"nvim-treesitter/nvim-treesitter", lazy = true},
  {"nvim-treesitter/playground", lazy = true},

  -- Copilot
  -- "github/copilot.vim",
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        require("copilot").setup()
      end)
    end
  },
  
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  },

  -- Git
  "lewis6991/gitsigns.nvim",

  -- TO DO
  {
    "AmeerTaweel/todo.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
        require("todo").setup()
    end
  },

  -- LSP
  "neovim/nvim-lspconfig",
  { "williamboman/mason.nvim", lazy = true }, -- simple to use language server installer
  { "williamboman/mason-lspconfig.nvim", lazy = true }, -- simple to use language server installer
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  {
    "goolord/alpha-nvim",
    event = 'VimEnter',
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  }
}

require("lazy").setup(plugins, opts)


-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup lazy_user_config
    autocmd!
    autocmd BufWritePost plugins.lua Lazy install
  augroup end
]]




-- Install your plugins here
--[[ return packer.startup(function(use) ]]
--[[   -- My plugins here ]]
--[[   use "lewis6991/impatient.nvim" ]]
--
--[[   use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight ]]
--[[   use "folke/which-key.nvim" ]]
--[[   use "sheerun/vim-polyglot" ]]
--[[   use "belltoy/prom.vim" ]]
--
--[[   use "earthly/earthly.vim" ]]
--[[   use "johnfrankmorgan/whitespace.nvim" ]]
--[[]]
--[[   -- accelerated-jk nvim ]]
--[[]]
--[[   -- Colorschemes ]]
--[[   use "tanvirtin/monokai.nvim" ]]
--[[   -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out ]]
--[[   -- use "lunarvim/darkplus.nvim" ]]
--[[]]
--[[   -- Lua ]]
--[[   -- Git ]]
--[[   use "lewis6991/gitsigns.nvim" ]]
--[[]]
--[[]]
--[[ end) ]]
