local conform = require 'conform'

conform.setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_format', 'ruff_organize_imports', 'autopep8', 'autoflake' },
    makefile = { 'bake' },
    bash = { 'beautysh' },
    rust = { 'rustfmt' },
    javascript = { 'biome', 'biome-check', 'biome-organize-imports' },
    typescript = { 'biome', 'biome-check', 'biome-organize-imports' },
    nix = { 'alejandra' },
    markdown = { 'cbfmt', 'doctoc', 'prettierd' },
    c = { 'clang-format' },
    css = { 'biome', 'biome-check', 'biome-organize-imports' },
    cpp = { 'clang-format' },
    toml = { 'taplo' },
    ['yaml.ghaction'] = { 'prettierd' },

    yaml = { 'prettierd' },
    json = { 'fixjson' },
    gleam = { 'gleam' },
    html = { 'rustywind', 'biome', 'biome-check', 'biome-organize-imports' },
    just = { 'just' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
}
