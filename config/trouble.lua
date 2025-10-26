local trouble = require 'trouble'

trouble.setup()

-- vim.api.nvim_create_user_command('Trouble', function()
--   require 'trouble'
-- end, {})

vim.keymap.set('n', '<leader>xx', function()
  trouble.toggle { mode = 'diagnostics', focus = true }
end, { desc = 'Diagnostics (Trouble)' })

vim.keymap.set('n', '<leader>cs', function()
  trouble.toggle { mode = 'symbols', focus = true }
end, { desc = 'Symbols (Trouble)' })

vim.keymap.set('n', '<leader>cl', function()
  trouble.toggle { mode = 'lsp', focus = false }
end, { desc = 'LSP Definitions / references / ... (Trouble)' })

vim.keymap.set('n', '<leader>xL', function()
  trouble.toggle { mode = 'loclist', focus = true }
end, { desc = 'Location List (Trouble)' })

vim.keymap.set('n', '<leader>xQ', function()
  trouble.toggle { mode = 'qflist', focus = true }
end, { desc = 'Quickfix List (Trouble)' })
