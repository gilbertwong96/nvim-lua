-- require('settings')    -- lua/settings.lua
-- require('maps')        -- lua/maps.lua
-- require('statusline')  -- lua/statusline.lua

local o = vim.opt
-- local wo = vim.wo
-- local bo = vim.bo

-----------------
-- global options
-----------------

-- Basic settings
o.termguicolors = true -- set true color in terminal
o.swapfile = true  -- Use a swapfile for the buffer.
o.updatetime = 200 -- If this many milliseconds nothing is typed the swap file will be written to disk
o.fileformat = 'unix' -- <nl> for EOL
o.switchbuf = 'useopen'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.backspace = "eol,start,indent"
o.matchpairs = "(:),{:},[:],<:>"
o.showmode = true
o.showcmd = true
o.cmdheight = 1
o.laststatus = 2
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = 'yes'
vim.g.colorcolumn = 100
o.ruler = true
o.wrap = true -- wrap long lines
o.breakindent = true
o.linebreak = true

o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.shiftround = true
o.smarttab = true

o.dir = '/tmp'
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 5

o.clipboard = "unnamed"

-- c: auto-wrap comments using textwidth
-- r: auto-insert the current comment leader after hitting <Enter>
-- o: auto-insert the current comment leader after hitting 'o' or 'O'
-- q: allow formatting comments with 'gq'
-- n: recognize numbered lists
-- 1: don't break a line after a one-letter word
-- j: remove comment leader when it makes sense
-- this gets overwritten by ftplugins (:verb set fo)
-- we use autocmd to remove 'o' in '/lua/autocmd.lua'
-- borrowed from tjdevries
o.formatoptions = o.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

o.splitbelow = true
o.splitright = true

o.foldenable = true      -- enable folding
o.foldlevelstart = 10        -- open most folds by default
o.foldnestmax = 10        -- 10 nested fold max
o.foldmethod = 'indent'  -- fold based on indent level

o.undofile = false     -- no undo file
o.hidden = true      -- do not unload buffer when abandoned
o.autochdir = false     -- do not change dir when opening a file


o.hlsearch = true      -- highlight all text matching current search pattern
o.incsearch = true      -- show search matches as you type
o.ignorecase = true      -- ignore case on search
o.smartcase = true      -- case sensitive when search includes uppercase
o.showmatch = true      -- highlight matching [{()}]
o.inccommand = 'nosplit' -- show search and replace in real time
o.autoread = true  -- auto read file if changed outside of vim 
o.wrapscan = true      -- begin search from top of the file when nothing is found
vim.o.cpoptions = vim.o.cpoptions .. 'x' -- stay on search item when <esc>

o.backup = false     -- no backup file
o.writebackup = false     -- do not backup file before write
o.swapfile = false     -- no swap file

--[[
  ShDa (viminfo for vim): session data history
  --------------------------------------------
  ! - Save and restore global variables (their names should be without lowercase letter).
  ' - Specify the maximum number of marked files remembered. It also saves the jump list and the change list.
  < - Maximum of lines saved for each register. All the lines are saved if this is not included, <0 to disable pessistent registers.
  % - Save and restore the buffer list. You can specify the maximum number of buffer stored with a number.
  / or : - Number of search patterns and entries from the command-line history saved. o.history is used if it’s not specified.
  f - Store file (uppercase) marks, use 'f0' to disable.
  s - Specify the maximum size of an item’s content in KiB (kilobyte).
      For the viminfo file, it only applies to register.
      For the shada file, it applies to all items except for the buffer list and header.
  h - Disable the effect of 'hlsearch' when loading the shada file.
  :ldfiles - all files with a mark in the shada file
  :rshada   - read the shada file (:rviminfo for vim)
  :wshada   - write the shada file (:wrviminfo for vim)
]]
o.shada             = [[!,'100,<0,s100,h]]
o.sessionoptions    = 'blank,buffers,curdir,folds,help,tabpages,winsize'
o.diffopt           = 'internal,filler,algorithm:histogram,indent-heuristic'


-- MacOS clipboard
if require 'utils'.is_darwin() then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
  }
end


-- use ':grep' to send resulsts to quickfix
-- use ':lgrep' to send resulsts to loclist
if vim.fn.executable('rg') == 1 then
    o.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
    o.grepformat = '%f:%l:%c:%m'
end


-- Disable providers we do not care a about
vim.g.loaded_python_provider  = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- Disable some in built plugins completely
local disabled_built_ins = {
  -- 'netrw',
  -- 'netrwPlugin',
  -- 'netrwSettings',
  -- 'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'fzf',
  -- 'matchit',
  -- 'matchparen'
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end


vim.g.markdown_fenced_languages = {
  'vim',
  'lua',
  'cpp',
  'sql',
  'python',
  'bash=sh',
  'console=sh',
  'javascript',
  'typescript',
  'js=javascript',
  'ts=typescript',
  'yaml',
  'json',
}

-- Map leader to <space>
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- window-local options
-- wo.number = true
-- wo.wrap = false

-- buffer-local options

require('plugins')
require('autocmd')
require('keymaps')

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

pcall(vim.cmd, [[colorscheme nvcode]])

