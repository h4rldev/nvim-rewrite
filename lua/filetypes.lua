local M = {}

local function add_filetype(patterns, filetype)
  for _, pattern in ipairs(patterns) do
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
      pattern = pattern,
      callback = function()
        vim.bo.filetype = filetype
      end,
    })
  end
end
function M.setup()
  add_filetype({ '**/.github/workflows/*.yml', '**/.github/workflows/*.yaml' }, 'yaml.ghaction')
  add_filetype({ '**/*.mdx' }, 'markdownx')
end

return M
