if not pcall(require, "nvim-treesitter") then
    return
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "bash",
      "c",
      "cpp",
      "go",
      "erlang",
      "elixir",
      "haskell",
      "javascript",
      "typescript",
      "json",
      "jsonc",
      "jsdoc",
      "lua",
      "python",
      "rust",
      "html",
      "css",
      "toml",
      "markdown",
      -- for `nvim-treesitter/playground`
      "query",
  },
  highlight   = {
    enable = true,
    -- slow on big files
    -- ugly for markdown
    disable = {
      -- "c", "cpp",
      "md", "markdown",
    }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = '<Tab>',
      -- scope_incremental = '<CR>',
      node_incremental = '<Tab>',
      node_decremental = '<S-Tab>',
    },
  },
  textobjects = {
    select = {
      enable  = true,
      keymaps = {
        ["ac"] = "@comment.outer"    ,
        ["ao"] = "@class.outer"      ,
        ["io"] = "@class.inner"      ,
        ["af"] = "@function.outer"   ,
        ["if"] = "@function.inner"   ,
        -- Leader mappings, dups for whichkey
        ["<Leader><Leader>ab"] = "@block.outer"      ,
        ["<Leader><Leader>ib"] = "@block.inner"      ,
        ["<Leader><Leader>af"] = "@function.outer"   ,
        ["<Leader><Leader>if"] = "@function.inner"   ,
        ["<Leader><Leader>ao"] = "@class.outer"      ,
        ["<Leader><Leader>io"] = "@class.inner"      ,
        ["<Leader><Leader>aC"] = "@call.outer"       ,
        ["<Leader><Leader>iC"] = "@call.inner"       ,
        ["<Leader><Leader>ac"] = "@conditional.outer",
        ["<Leader><Leader>ic"] = "@conditional.inner",
        ["<Leader><Leader>al"] = "@loop.outer"       ,
        ["<Leader><Leader>il"] = "@loop.inner"       ,
        ["<Leader><Leader>ap"] = "@parameter.outer"  ,
        ["<Leader><Leader>ip"] = "@parameter.inner"  ,
        ["<Leader><Leader>is"] = "@scopename.inner"  ,
        ["<Leader><Leader>as"] = "@statement.outer"  ,
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}

--[[
  https://github.com/nvim-treesitter/nvim-treesitter/issues/1168
  ** use lowercase 'solidity':
  ```
    ??? nm -gD .local/share/nvim/site/pack/packer/start/nvim-treesitter/parser/Solidity.so
                       w _ITM_deregisterTMCloneTable
                       w _ITM_registerTMCloneTable
                       w __cxa_finalize@@GLIBC_2.2.5
                       w __gmon_start__
      00000000000232e0 T tree_sitter_solidity
  ```
  To install:
  ```
    ??? mkdir ~/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/queries/solidity/
    ??? curl -L https://raw.githubusercontent.com/JoranHonig/tree-sitter-solidity/master/queries/highlights.scm -o ~/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/queries/solidity/highlights.scm
    ??? vi ~/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/queries/solidity/highlights.scm
  ```
  ** comment out lines 68-69
]]
if pcall(require, "nvim-treesitter.parsers") then
  require "nvim-treesitter.parsers".get_parser_configs().solidity = {
    install_info = {
      url = "https://github.com/JoranHonig/tree-sitter-solidity",
      files = {"src/parser.c"},
      requires_generate_from_grammar = true,
    },
    filetype = 'solidity'
  }
  -- install with ':TSInstallSync markdown'
  --[[ require "nvim-treesitter.parsers".get_parser_configs().markdown = {
    install_info = {
      url = "https://github.com/ikatyang/tree-sitter-markdown",
      files = { "src/parser.c", "src/scanner.cc" },
      -- makes treesitter ignore the 'lockfile.json' revision
      -- won't compile without this like as it tries the default
      -- markdown revision from 'MDeiml/tree-sitter-markdown'
      revision = "master",
    }
  } ]]
end
