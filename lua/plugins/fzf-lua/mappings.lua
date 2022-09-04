--- Credit to ibhagwan
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/fzf-lua/mappings.lua

local map_fzf = function(mode, key, f, options, buffer)

  local rhs = function()
    if not pcall(require, 'fzf-lua') then
      require('packer').loader('fzf-lua')
    end
    require('plugins.fzf-lua')[f](options or {})
  end

  local map_options = {
    noremap = true,
    silent = true,
    buffer = buffer,
  }

  require('utils').remap(mode, key, rhs, map_options)
end

-- mappings
map_fzf('n', '<F1>', "help_tags")
map_fzf('n', '<c-P>', "files", {})
map_fzf('n', '<c-K>', "workdirs", {
  winopts = {
    height       = 0.40,
    width        = 0.60,
    row          = 0.40,
  }})
map_fzf('n', '<leader>bb', "buffers")
map_fzf('n', '<leader>fr', "grep", {})
map_fzf('n', '<leader>/',  "grep_project", {})
-- map_fzf('n', '<leader>fR', "live_grep", { repeat_last_search = true })
map_fzf('n', '<leader>ff', "files")
-- map_fzf('n', '<leader>ff', "grep", { repeat_last_search = true} )
map_fzf('n', '<leader>fw', "grep_cword")
map_fzf('n', '<leader>fW', "grep_cWORD")
map_fzf('n', '<leader>fv', "grep_visual")
map_fzf('v', '<leader>fv', "grep_visual")
map_fzf('n', '<leader>ss', "blines")
map_fzf('n', '<leader>sS', "lgrep_curbuf", { prompt = 'Buffer❯ ' })
map_fzf('n', '<leader>pf', "files", {})
map_fzf('n', '<leader>gff', "git_files", {})
map_fzf('n', '<leader>fr', "oldfiles", { cwd = "~" })
map_fzf('n', '<leader>fR', "oldfiles", function()
  return {
    cwd = vim.loop.cwd(),
    show_cwd_header = true,
    cwd_only = true,
  }
end)
map_fzf('n', '<leader>fq', "quickfix")
map_fzf('n', '<leader>fQ', "loclist")
map_fzf('n', '<leader>fo', "colorschemes")
map_fzf('n', '<leader>fO', "highlights")
map_fzf('n', '<leader>fM', "marks")

--jump configs
map_fzf('n', '<leader>en', "edit_neovim")
map_fzf('n', '<leader>eo', "edit_fish")
map_fzf('n', '<leader>ea', "edit_alacritty")
map_fzf('n', '<leader>ep', "installed_plugins")

-- LSP
map_fzf('n', '<localleader>gr', "lsp_references")
map_fzf('n', '<localleader>gd', "lsp_definitions", { jump_to_single_result = false })
map_fzf('n', '<localleader>gD', "lsp_declarations")
map_fzf('n', '<localleader>gt', "lsp_typedefs")
map_fzf('n', '<localleader>gi', "lsp_implementations")
map_fzf('n', '<leader>ji', "lsp_document_symbols")
map_fzf('n', '<localleader>gs', "lsp_workspace_symbols")
map_fzf('n', '<localleader>aa', "lsp_code_actions", {
  winopts = {
    win_height       = 0.30,
    win_width        = 0.70,
    win_row          = 0.40,
  }})
map_fzf('n', '<leader>lg', "lsp_document_diagnostics", { file_icons = false })
map_fzf('n', '<leader>lG', "lsp_workspace_diagnostics", { file_icons = false })

-- Git
map_fzf('n', '<leader>gs', "git_status")
-- Full screen git status
-- map_fzf('n', '<leader>fS', "git_status_tmuxZ", {
--   winopts = {
--     fullscreen = true,
--     preview = {
--       vertical = "down:70%",
--       horizontal = "right:70%",
--     }
--   }
-- })
map_fzf('n', '<leader>g/', "git_commits")
map_fzf('n', '<leader>g*', "git_bcommits")
map_fzf('n', '<leader>gB', "git_branches")

-- Fzf-lua methods
map_fzf('n', "<leader>f?", "builtin")
map_fzf('n', '<leader>fm', "man_pages")
map_fzf('n', '<leader>fx', "commands")
map_fzf('n', '<leader>f:', "command_history")
map_fzf('n', '<leader>f/', "search_history")
map_fzf('n', '<leader>f"', "registers")
map_fzf('n', '<leader>fk', "keymaps")
map_fzf('n', '<leader>fz', "spell_suggest", {
  winopts = {
    win_height       = 0.60,
    win_width        = 0.50,
    win_row          = 0.40,
  }})
map_fzf('n', '<leader>fT', "tags")
map_fzf('n', '<leader>ft', "btags")
map_fzf('n', '<leader>ht', "help_tags")


