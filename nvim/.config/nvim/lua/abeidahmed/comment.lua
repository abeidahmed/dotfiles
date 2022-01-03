require('Comment').setup {}

local ft = require('Comment.ft')

ft.set('lua', { '--%s', '--[[%s]]' })
ft.set('html.handlebars', { '{{!-- %s --}}', '{{!-- %s --}}' })
