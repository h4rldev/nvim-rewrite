local nvterm = require 'nvterm'
local nvterm_terminal = require 'nvterm.terminal'

nvterm.setup {
  terminals = {
    shell = vim.o.shell,
    list = {},
    type_opts = {
      float = {
        relative = 'editor',
        row = 0.3,
        col = 0.25,
        width = 0.5,
        height = 0.4,
        border = 'single',
      },
      horizontal = { location = 'rightbelow', split_ratio = 0.3 },
      vertical = { location = 'rightbelow', split_ratio = 0.5 },
    },
  },
  behavior = {
    autoclose_on_quit = {
      enabled = false,
      confirm = true,
    },
    close_on_exit = true,
    auto_insert = true,
  },
}

local toggle_modes = { 'n', 't' }
local mappings = {
  {
    toggle_modes,
    '<A-h>',
    function()
      nvterm_terminal.toggle 'horizontal'
    end,
    { silent = true, noremap = true, desc = 'Toggle horizontal terminal' },
  },
  {
    toggle_modes,
    '<A-v>',
    function()
      nvterm_terminal.toggle 'vertical'
    end,
    { silent = true, noremap = true, desc = 'Toggle vertical terminal' },
  },
  {
    toggle_modes,
    '<A-i>',
    function()
      nvterm_terminal.toggle 'float'
    end,
    { silent = true, noremap = true, desc = 'Toggle floating terminal' },
  },
}

if vim.fn.executable 'lazygit' == 1 then
  mappings[#mappings + 1] = {
    toggle_modes,
    '<A-s>',
    function()
      nvterm_terminal.send('lazygit', 'float')
    end,
    { silent = true, noremap = true, desc = 'Open Lazygit' },
  }
end

for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping[1], mapping[2], mapping[3], mapping[4])
end
