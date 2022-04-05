local res, indent = pcall(require, "indent_blankline")
if not res then
  return
end

local res, indent = pcall(require, "indent_blankline")
if not res then
  return
end

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

local opts = {
  enabled = true,
  -- char = "│",
  -- char_list = { '│', '┆', '|', '┊' },
  space_char_blankline = ' ',
  use_treesitter = true,
  show_end_of_line = true,
  show_first_indent_level = true,
  disable_with_nolist = false,
  filetype_exclude = { 'txt', 'text' },
  buftype_exclude = { 'terminal', 'nofile', 'help' },
  strict_tabs = true,
  show_current_context = true,
  show_current_context_start = true,
  char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },  
}

if not pcall(require, "nvim-treesitter") then
  -- will prevent plugin from working when
  -- treesitter is not available (no C compiler)
  opts.use_treesitter = false
  opts.show_current_context = false
  opts.show_current_context_start = false
end

indent.setup(opts)

-- vim.api.nvim_set_keymap('', '<leader>"', '<Esc>:IndentBlanklineToggle<CR>',
vim.api.nvim_set_keymap('', '<leader>"',
  '<cmd>lua require("indent_blankline.commands").toggle("<bang>" == "!")<CR>',
  { noremap = true, silent = true })
