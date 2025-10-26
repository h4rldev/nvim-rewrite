vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_border_chars = {
  '╭',
  '─',
  '╮',
  '│',
  '╯',
  '─',
  '╰',
  '│',
} -- customize lazygit popup window border characters
vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 0
vim.g.lazygit_use_custom_config_file_path = 0

vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { silent = true, desc = '[L]azy[G]it' })
