--- Credit to ibhagwan
-- https://github.com/ibhagwan/nvim-lua/blob/main/lua/workdirs.lua

return {
  vim.loop.cwd(),
  -- runtime path
  vim.opt.runtimepath._info.default:match("/[^,]+runtime"),
  '~/.config/nvim',
  '~/.config/fish',
  '~/.config/alacritty',
  vim.fn.stdpath("data") .. "/site/pack/packer",
}
