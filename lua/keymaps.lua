local remap = require'utils'.remap
local command = require'utils'.command

-- Shortcuts for editing the keymap file and reloading the config
vim.cmd [[command! -nargs=* NvimEditInit split | edit $MYVIMRC]]
vim.cmd [[command! -nargs=* NvimEditKeymap split | edit ~/.config/nvim/lua/keymaps.lua]]
vim.cmd [[command! -nargs=* NvimSourceInit luafile $MYVIMRC]]

-- Use ':Grep' or ':LGrep' to grep into quickfix|loclist
-- without output or jumping to first match
-- Use ':Grep <pattern> %' to search only current file
-- Use ':Grep <pattern> %:h' to search the current file dir
vim.cmd("command! -nargs=+ -complete=file Grep " ..
    "lua vim.api.nvim_exec([[noautocmd grep! <args> | redraw! | copen]], true)")
vim.cmd("command! -nargs=+ -complete=file LGrep " ..
    "lua vim.api.nvim_exec([[noautocmd lgrep! <args> | redraw! | lopen]], true)")

remap('', '<leader>ei', '<Esc>:NvimEditInit<CR>',   { silent = true })
remap('', '<leader>ek', '<Esc>:NvimEditKeymap<CR>', { silent = true })
-- remap('', '<leader>R',  "<Esc>:NvimRestart<CR>",    { silent = true })

-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])

-- jk instead of escape
remap({'i'}, 'jk', '<ESC>', {silent = true})

-- <ctrl-s> to Save
remap({ 'n', 'v', 'i'}, '<C-S>', '<cmd>:wa<cr>', { silent = true })

-- w!! to save with sudo
remap('c', 'w!!', "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })

-- Beginning and end of line in `:` command mode
remap('c', '<C-a>', '<home>', {})
remap('c', '<C-e>', '<end>' , {})

-- Terminal mappings
remap('t', '<M-[>', [[<C-\><C-n>]],      { noremap = true })
remap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true })
remap('t', '<M-r>', [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { noremap = true, expr = true })

-- tmux like directional window resizes
remap('n', '<leader><Up>', "<cmd>lua require'utils'.resize(false, -5)<CR>",
    { noremap = true, silent = true })
remap('n', '<leader><Down>',  "<cmd>lua require'utils'.resize(false,  5)<CR>",
    { noremap = true, silent = true })
remap('n', '<leader><Left>',  "<cmd>lua require'utils'.resize(true,  -5)<CR>",
    { noremap = true, silent = true })
remap('n', '<leader><Right>', "<cmd>lua require'utils'.resize(true,   5)<CR>",
    { noremap = true, silent = true })
remap('n', '<leader>=',       '<C-w>=', { noremap = true, silent = true })

-- Navigate window
remap('n', '<leader>wh', '<C-w>h', { noremap = true, silent = true })
remap('n', '<leader>wj', '<C-w>j', { noremap = true, silent = true })
remap('n', '<leader>wk', '<C-w>k', { noremap = true, silent = true })
remap('n', '<leader>wl', '<C-w>l', { noremap = true, silent = true })

-- Split window
remap('n', '<leader>w-', ':sp<CR>', { noremap = true, silent = true })
remap('n', '<leader>w|', ':vs<CR>', { noremap = true, silent = true })

-- Delete window
remap('n', '<leader>wd', ':quit<CR>', { noremap = true, silent = true })

-- Save file in current window
remap('n', '<leader>ws', ':w<CR>', { noremap = true, silent = true })

-- Tab navigation
remap('n', '[t',         ':tabprevious<CR>', { noremap = true })
remap('n', ']t',         ':tabnext<CR>',     { noremap = true })
remap('n', '[T',         ':tabfirst<CR>',    { noremap = true })
remap('n', ']T',         ':tablast<CR>',     { noremap = true })
remap('n', '<Leader>tn', ':tabnew<CR>',      { noremap = true })
remap('n', '<Leader>tc', ':tabclose<CR>',    { noremap = true })
remap('n', '<Leader>to', ':tabonly<CR>',    { noremap = true })
-- Jump to first tab & close all other tabs. Helpful after running Git difftool.
remap('n', '<Leader>tO', ':tabfirst<CR>:tabonly<CR>', { noremap = true })
-- tmux <c-meta>z like
remap('n', '<Leader>tz',  "<cmd>lua require'utils'.tabZ()<CR>", { noremap = true })

-- Delete buffer
remap('n', '<leader>bd', ':bw<CR>', { noremap = true, silent = true })

-- Navigate buffers
remap('n', '[b', ':bprevious<CR>',      { noremap = true })
remap('n', ']b', ':bnext<CR>',          { noremap = true })
remap('n', '[B', ':bfirst<CR>',         { noremap = true })
remap('n', ']B', ':blast<CR>',          { noremap = true })

-- Quickfix list mappings
remap('n', '<leader>qq', "<cmd>lua require'utils'.toggle_qf('q')<CR>", { noremap = true })
remap('n', '[q', ':cprevious<CR>',      { noremap = true })
remap('n', ']q', ':cnext<CR>',          { noremap = true })
remap('n', '[Q', ':cfirst<CR>',         { noremap = true })
remap('n', ']Q', ':clast<CR>',          { noremap = true })

-- Location list mappings
remap('n', '<leader>ql', "<cmd>lua require'utils'.toggle_qf('l')<CR>", { noremap = true })
remap('n', '[l', ':lprevious<CR>',      { noremap = true })
remap('n', ']l', ':lnext<CR>',          { noremap = true })
remap('n', '[L', ':lfirst<CR>',         { noremap = true })
remap('n', ']L', ':llast<CR>',          { noremap = true })

-- shortcut to view :messages
remap({'n', 'v'}, '<leader>m', '<cmd>messages<CR>',  { noremap = true })
remap({'n', 'v'}, '<leader>M', '<cmd>mes clear|echo "cleared :messages"<CR>', { noremap = true })

-- Move selected lines up/down in visual mode
remap('x', 'K', ":move '<-2<CR>gv=gv", { noremap = true })
remap('x', 'J', ":move '>+1<CR>gv=gv", { noremap = true })

-- Keep matches center screen when cycling with n|N
remap('n', 'n', 'nzzzv', { noremap = true })
remap('n', 'N', 'Nzzzv', { noremap = true })
-- any jump over 5 modifies the jumplist
--
-- so we can use <C-o> <C-i> to jump back and forth
for _, c in ipairs({'j', 'k'}) do
  remap('n', c, ([[(v:count > 5 ? "m'" . v:count : "") . '%s']]):format(c),
    { noremap=true, expr = true, silent = true})
end

-- Search and Replace
-- 'c.' for word, '<leader>c.' for WORD
remap('n', 'c.',         [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true })
remap('n', '<leader>c.', [[:%s/\<<C-r><C-a>\>//g<Left><Left>]], { noremap = true })

-- Turn off search matches with double-<Esc>
remap('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR>', { noremap = true, silent = true })

-- Toggle display of `listchars`
remap('n', '<leader>\'', '<Esc>:set list!<CR>',   { noremap = true, silent = true })

-- Toggle colored column at 81
remap('n', '<leader>|',
    ':execute "set colorcolumn=" . (&colorcolumn == "" ? "100" : "")<CR>',
    { noremap = true, silent = true })

-- Change current working dir (:pwd) to curent file's folderhttp://vimcasts.org/transcripts/61/en/
remap('n', '<leader>%', '<Esc>:lua require"utils".set_cwd()<CR>', { noremap = true, silent = true })

-- Quic neovim
remap('n', '<leader>Q', ':qa<CR>', { noremap = true, silent = true })
