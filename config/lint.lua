local lint = require 'lint'

local function is_linter_available(linter_name)
  return vim.fn.executable(linter_name) == 1
end
local function get_available_linters(linter_table)
  local ready_linter_table = {}

  if not linter_table then
    vim.notify('Error: linter table is nil', vim.log.levels.ERROR)
    return
  end

  for name, linters in pairs(linter_table) do
    local ready_linters = {}
    for _, linter in ipairs(linters) do
      if is_linter_available(linter) then
        ready_linters[#ready_linters + 1] = linter
      end
    end

    ready_linter_table[name] = ready_linters
  end

  return ready_linter_table
end

local function set_available_global_linters(global_linter_list)
  for _, linter in ipairs(global_linter_list) do
    if is_linter_available(linter) then
      lint.try_lint(linter)
    end
  end
end

local linters = {
  markdown = { 'markdownlint', 'alex' },
  html = { 'alex' },
  markdownx = { 'alex' },
  python = { 'ruff', 'bandit' },
  ['yaml.ghaction'] = { 'actionlint' },
  javascript = { 'biomejs' },
  typescript = { 'biomejs' },
  css = { 'biomejs' },
  txt = { 'alex' },
  json = { 'biomejs' },
  jsonc = { 'biomejs' },
  lua = { 'luacheck' },
  make = { 'checkmake' },
  c = { 'clang-tidy' },
  cpp = { 'clang-tidy' },
  dockerfile = { 'hadolint' },
}

local global_linter_list = {
  'cspell',
}

lint.linters_by_ft = get_available_linters(linters)

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if vim.bo.modifiable then
      lint.try_lint()
      set_available_global_linters(global_linter_list)
    end
  end,
})

vim.api.nvim_create_user_command('LinterGetRunning', function()
  local linter_list = lint.get_running()
  if #linter_list == 0 then
    vim.notify 'No running linters'
    return
  end
  vim.notify('󱉶 ' .. table.concat(linter_list, ', '))
end, {})
