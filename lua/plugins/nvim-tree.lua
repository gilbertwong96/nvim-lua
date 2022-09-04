--- Credit to ibhagwan
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/nvim-tree.lua
local remap = vim.api.nvim_set_keymap

require'nvim-tree'.setup {
  open_on_setup       = false,
  open_on_tab         = false,
--[[   disable_netrw       = true, ]]
  hijack_netrw        = false,
  hijack_cursor       = false,
  update_cwd          = true,
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "H",
      info = "I",
      warning = "W",
      error = "E",
    }
  },
  view = {
    width = 30,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {
        { key = "<C-x>", action = nil },
        { key = "<C-s>", action = "split" },
      }
    }
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  filters = {
    dotfiles = false,
    custom = {
      ".git",
      ".sumneko_lua",
      ".cache",
      "node_modules",
      "__pycache__",
    }
  },
}
