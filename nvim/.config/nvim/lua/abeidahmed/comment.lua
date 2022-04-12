local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {}

local ft = require('Comment.ft')

ft.set('lua', { '--%s', '--[[%s]]' })
ft.set('html.handlebars', { '{{!-- %s --}}', '{{!-- %s --}}' })
