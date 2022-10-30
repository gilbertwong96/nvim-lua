local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,

  padding = true, -- Add a space b/w comment and the line
  sticky = true, -- Whether the cursor should stay at its position

  -- NORMAL mode line-wise mappings
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },

  -- NORMAL+VISUAL mode operator mappings
  opleader = {
    line = 'gl',
    block = 'gc',
  },

  extra = {
    above = 'gcO', -- Add comment on the line above
    below = 'gco', -- Add comment on the line below
    eol = 'gcA', -- Add comment at the end of line
  },

  mappings = {
    basic = true, -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    extra = true, -- Includes `gco`, `gcO`, `gcA`
    extended = false, -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
  },
}
