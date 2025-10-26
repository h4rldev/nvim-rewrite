local snacks_setup = require 'snacks'

local explorer_config = {
  finder = 'explorer',
  sort = { fields = { 'sort' } },
  supports_live = true,
  tree = true,
  watch = true,
  diagnostics = true,
  diagnostics_open = false,
  git_status = true,
  git_status_open = false,
  git_untracked = true,
  follow_file = true,
  focus = 'list',
  auto_close = false,
  jump = { close = false },
  layout = { preset = 'sidebar', preview = false },
  -- to show the explorer to the right, add the below to
  -- your config under `opts.picker.sources.explorer`
  -- layout = { layout = { position = "right" } },
  formatters = {
    file = { filename_only = true },
    severity = { pos = 'right' },
  },
  matcher = { sort_empty = false, fuzzy = false },
  config = function(opts)
    return require('snacks.picker.source.explorer').setup(opts)
  end,
  win = {
    list = {
      keys = {
        ['<BS>'] = 'explorer_up',
        ['l'] = 'confirm',
        ['h'] = 'explorer_close', -- close directory
        ['a'] = 'explorer_add',
        ['d'] = 'explorer_del',
        ['r'] = 'explorer_rename',
        ['c'] = 'explorer_copy',
        ['m'] = 'explorer_move',
        ['o'] = 'explorer_open', -- open with system application
        ['P'] = 'toggle_preview',
        ['y'] = { 'explorer_yank', mode = { 'n', 'x' } },
        ['p'] = 'explorer_paste',
        ['u'] = 'explorer_update',
        ['<c-c>'] = 'tcd',
        ['<leader>/'] = 'picker_grep',
        ['<c-t>'] = 'terminal',
        ['.'] = 'explorer_focus',
        ['I'] = 'toggle_ignored',
        ['H'] = 'toggle_hidden',
        ['Z'] = 'explorer_close_all',
        [']g'] = 'explorer_git_next',
        ['[g'] = 'explorer_git_prev',
        [']d'] = 'explorer_diagnostic_next',
        ['[d'] = 'explorer_diagnostic_prev',
        [']w'] = 'explorer_warn_next',
        ['[w'] = 'explorer_warn_prev',
        [']e'] = 'explorer_error_next',
        ['[e'] = 'explorer_error_prev',
      },
    },
  },
}

local notifier_config = {
  timeout = 3000, -- default timeout in ms
  width = { min = 40, max = 0.4 },
  height = { min = 1, max = 0.6 },
  -- editor margin to keep free. tabline and statusline are taken into account automatically
  margin = { top = 0, right = 1, bottom = 1 },
  padding = true, -- add 1 cell of left/right padding to the notification window
  gap = 0, -- gap between notifications
  sort = { 'level', 'added' }, -- sort by level and time
  -- minimum log level to display. TRACE is the lowest
  -- all notifications are stored in history
  level = vim.log.levels.TRACE,
  icons = {
    error = ' ',
    warn = ' ',
    info = ' ',
    debug = ' ',
    trace = ' ',
  },
  keep = function()
    return vim.fn.getcmdpos() > 0
  end,
  ---@type snacks.notifier.style
  style = 'minimal',
  top_down = false, -- place notifications from top to bottom
  date_format = '%R', -- time format for notifications
  -- format for footer when more lines are available
  -- `%d` is replaced with the number of lines.
  -- only works for styles with a border
  ---@type string|boolean
  more_format = ' ↓ %d lines ',
  refresh = 50, -- refresh at most every 50ms
}

snacks_setup.setup {
  explorer = {
    replace_netrw = true,
    trash = true,
  },
  picker = {
    sources = {
      explorer = explorer_config,
    },
  },
  gitbrowse = {
    enabled = true,
  },
  input = {
    enabled = true,
  },
  indent = {
    enabled = true,
  },
  image = {
    enabled = true,
  },
  notifier = notifier_config,
  notify = {
    enabled = true,
  },
  lazygit = {
    enabled = true,
  },
}

_G.Snacks = snacks_setup

vim.keymap.set('n', '<C-e>', function()
  Snacks.explorer()
end, { desc = 'Open Snacks [e]xplorer' })

vim.keymap.set('n', '<leader>o', function()
  Snacks.gitbrowse()
end, { desc = 'Git Repository [o]pen' })

vim.keymap.set('n', '<leader>lg', function()
  Snacks.lazygit()
end, { desc = 'Open [l]azy[g]it' })
